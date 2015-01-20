<?php

namespace Plugins;

class ImageUpload extends PluginBase {

	protected $_maxSize = 2048;

	public function __construct($governor) {
		parent::__construct("Image Uploader", $governor);
	}

	public function Run($op, $args, &$buffer) {
		if($this->_isMe($op)) {
			$subs = $this->_parseSubCommands($op);
			if(!isset($subs[1])) { $subs = array($subs, 'UploadImages'); }
			switch($subs[1]) {
				case "UploadImages":
                                    error_log("UploadImages with ".print_r($_FILES, true));
					$this->_processUploadedImages($args, $_FILES['images'], $buffer);
					break;
				default:
					error_log("Unknown op $op\n".print_r($subs,true));
					break;

			}
		}
		return true;
	}

	protected function _processUploadedImages($args, $files, &$data) {
                if( !$args || empty($files)) { 
                    error_log("processing upload images with no args or files: ".print_r($args, true)."\n".print_r($files, true));
                    return $data; 
                }
                $images = $this->_restructureArray($files);
                $allowedExts = array("jpg", "jpeg", "gif", "png");

                foreach($images as $key => $value) {
                    $i = $key + 1;
                    $data[$i] = array();
                    $image_name = $value['name'];
                    $ext = strtolower(pathinfo($image_name, PATHINFO_EXTENSION));
                    $image_size = $value['size'] / 1024;
                    $image_flag = true;
                    if(!in_array($ext, $allowedExts)) {
                        $data[$i]['error'] = "$ext extension is not allowed.";
                        $image_flag = false;
                    } elseif ($image_size > $this->_maxSize) {
                        $data[$i]['error'] = "Image is $image_size KB which is bigger than the allowed {$this->_maxSize} KB size.";
                        $image_flag = false;
                    } elseif ($value['error'] > 0) {
                        $data[$i]['error'] = "$image_name contains error with error code {$value['error']}";
                        $image_flag = false;
                    } else {
                        move_uploaded_file($value['tmp_name'], __DIR__."/../../images/properties/$image_name");
                        $this->_makeThumbnail(__DIR__."/../../images/properties/$image_name", __DIR__."/../../images/properties/thumb_$image_name", 500);
                        $this->_makeThumbnail(__DIR__."/../../images/properties/$image_name", __DIR__."/../../images/properties/icon_$image_name", 150);
                        $src = "images/properties/thumb_$image_name";
                        $data[$i]['success'] = $src;
                        $img = new \Common\Image();
                        $img->AddressID = $args['pid'];
                        $img->Name = (isset($args['name']) && $args['name'] ? $args['name'] : $image_name);
                        $img->File = $image_name;
                        $img->Weight = (isset($args['weight'])? $args['weight'] : 1000);
                        $img->Save();
                        $data[$i]['info'] = $img->ToArray();
                    }
                }
		return $data;
	}

	protected function _restructureArray(array $images) {
		$result = array();
		foreach($images as $k => $val) {
			for($i = 0; $i < count($val); $i++) {
				if(!isset($result[$i])) { $result[$i] = array(); }
				$result[$i][$k] = $val[$i];
			}
		}
		return $result;
	}

	protected function _makeThumbnail($src, $dist, $dis_width = 100) {

		$img = '';
		$extension = strtolower(strrchr($src, '.'));

		switch($extension) {
			case '.jpg':
			case '.jpeg':
				$img = @imagecreatefromjpeg($src);
				break;
			case '.gif':
				$img = @imagecreatefromgif($src);
				break;
			case '.png':
				$img = @imagecreatefrompng($src);
				break;
		}

		$width  = imagesx($img);
		$height = imagesy($img);
		$dis_height = $dis_width*($height/$width);
	
		$new_image = imagecreatetruecolor($dis_width, $dis_height);
		imagecopyresampled($new_image, $img, 0,0,0,0, $dis_width, $dis_height, $width, $height);

		$imageQuality = 100;

		switch($extension) {
			case '.jpg':
			case '.jpeg':
				if(imagetypes() & IMG_JPG) {
					imagejpeg($new_image, $dist, $imageQuality);
				}
				break;
			case '.gif':
				if(imagetypes() & IMG_GIF) {
					imagegif($new_image, $dist);
				}
				break;
			case '.png':
				$scaleQuality = round(($imageQuality/100)*9);
				$invertedScaleQuality = 9 - $scaleQuality;
				if(imagetypes() & IMG_PNG) {
					imagepng($new_image, $dist, $invertedScaleQuality);
				}
				break;
		}
		imagedestroy($new_image);
	}

}
