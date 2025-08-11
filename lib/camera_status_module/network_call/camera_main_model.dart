class CameraMainModel {
  List<Camera>? camera;

  CameraMainModel({this.camera});

  CameraMainModel.fromJson(Map<String, dynamic> json) {
    if (json['camera'] != null) {
      camera = <Camera>[];
      json['camera'].forEach((v) {
        camera!.add(Camera.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (camera != null) {
      data['camera'] = camera!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Camera {
  dynamic bRAND;
  dynamic cAMERAIP;
  dynamic cAMPOS;
  dynamic cAMNO;
  dynamic cATEGORY;
  dynamic fRAMERATE;
  dynamic fUNCTIONALITY;
  dynamic lINECROSSX;
  dynamic lINECROSSY;
  dynamic lIVEURL;
  dynamic rEGION;
  dynamic rOI;
  dynamic sECTION;
  dynamic sHIFT;
  dynamic sTATUS;
  dynamic sTORE;
  dynamic zONE;

  Camera({
    this.bRAND,
    this.cAMERAIP,
    this.cAMPOS,
    this.cAMNO,
    this.cATEGORY,
    this.fRAMERATE,
    this.fUNCTIONALITY,
    this.lINECROSSX,
    this.lINECROSSY,
    this.lIVEURL,
    this.rEGION,
    this.rOI,
    this.sECTION,
    this.sHIFT,
    this.sTATUS,
    this.sTORE,
    this.zONE,
  });

  Camera.fromJson(Map<String, dynamic> json) {
    bRAND = json['BRAND'];
    cAMERAIP = json['CAMERA_IP'];
    cAMPOS = json['CAMPOS'];
    cAMNO = json['CAM_NO'];
    cATEGORY = json['CATEGORY'];
    fRAMERATE = json['FRAMERATE'];
    fUNCTIONALITY = json['FUNCTIONALITY'];
    lINECROSSX = json['LINECROSS_X'];
    lINECROSSY = json['LINECROSS_Y'];
    lIVEURL = json['LIVE_URL'];
    rEGION = json['REGION'];
    rOI = json['ROI'];
    sECTION = json['SECTION'];
    sHIFT = json['SHIFT'];
    sTATUS = json['STATUS'];
    sTORE = json['STORE'];
    zONE = json['ZONE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BRAND'] = bRAND;
    data['CAMERA_IP'] = cAMERAIP;
    data['CAMPOS'] = cAMPOS;
    data['CAM_NO'] = cAMNO;
    data['CATEGORY'] = cATEGORY;
    data['FRAMERATE'] = fRAMERATE;
    data['FUNCTIONALITY'] = fUNCTIONALITY;
    data['LINECROSS_X'] = lINECROSSX;
    data['LINECROSS_Y'] = lINECROSSY;
    data['LIVE_URL'] = lIVEURL;
    data['REGION'] = rEGION;
    data['ROI'] = rOI;
    data['SECTION'] = sECTION;
    data['SHIFT'] = sHIFT;
    data['STATUS'] = sTATUS;
    data['STORE'] = sTORE;
    data['ZONE'] = zONE;
    return data;
  }
}
