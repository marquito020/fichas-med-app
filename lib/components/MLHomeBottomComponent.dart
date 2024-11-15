import 'package:fichas_med_app/model/EspecialidadModel.dart';
import 'package:fichas_med_app/services/especialidad_service.dart';
import 'package:flutter/material.dart';
import 'package:fichas_med_app/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fichas_med_app/model/MLDepartmentData.dart';
import 'package:fichas_med_app/model/MLTopHospitalData.dart';
import 'package:fichas_med_app/utils/MLColors.dart';
import 'package:fichas_med_app/utils/MLDataProvider.dart';
import 'package:fichas_med_app/utils/MLString.dart';

class MLHomeBottomComponent extends StatefulWidget {
  static String tag = '/MLHomeBottomComponent';
  @override
  MLHomeBottomComponentState createState() => MLHomeBottomComponentState();
}

class MLHomeBottomComponentState extends State<MLHomeBottomComponent> {
  List<EspecialidadModel> especialidades = [];
  List<MLDepartmentData> departmentList = mlDepartmentDataList();
  List<MLTopHospitalData> tophospitalList = mlTopHospitalDataList();
  EspecialidadService especialidadService = EspecialidadService();
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    especialidades = await especialidadService.getAllEspecialidades();
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        8.height,
        Row(
          children: [
            Text(mlDepartment!, style: boldTextStyle(size: 18)).expand(),
            Row(
              mainAxisSize: MainAxisSize
                  .min, // Mantiene los elementos ajustados a su contenido
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/especialidades');
                  },
                  child: Text(mlView_all!,
                      style: secondaryTextStyle(color: mlColorBlue)),
                ),
                4.width,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/especialidades');
                  },
                  child: Icon(Icons.keyboard_arrow_right,
                      color: mlColorBlue, size: 16),
                ),
              ],
            ),
          ],
        ).paddingOnly(left: 16, right: 16),
        10.height,
        HorizontalList(
          padding: EdgeInsets.only(right: 16.0, left: 8.0),
          wrapAlignment: WrapAlignment.spaceEvenly,
          itemCount: especialidades.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 8),
              padding: EdgeInsets.all(10),
              decoration: boxDecorationRoundedWithShadow(12,
                  backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    (departmentList[index].image).validate(),
                    height: 80,
                    width: 80,
                    fit: BoxFit.fill,
                  ).paddingAll(8.0),
                  Text((especialidades.elementAt(index).nombre).validate(),
                      style: boldTextStyle()),
                  4.height,
                  Text((departmentList[index].subtitle).validate(),
                      style: secondaryTextStyle()),
                  8.height,
                ],
              ),
            );
          },
        ),
        Row(
          children: [
            Text(mlTop_hospital!, style: boldTextStyle(size: 18)).expand(),
            Text(mlView_all!, style: secondaryTextStyle(color: mlColorBlue)),
            4.width,
            Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingAll(16.0),
        HorizontalList(
          padding: EdgeInsets.only(right: 16.0, left: 8.0),
          wrapAlignment: WrapAlignment.spaceBetween,
          itemCount: tophospitalList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8, left: 8),
              decoration: boxDecorationRoundedWithShadow(12,
                  backgroundColor: context.cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonCachedNetworkImage(
                    (tophospitalList[index].image).validate(),
                    height: 140,
                    width: 250,
                    fit: BoxFit.fill,
                  ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                  8.height,
                  Text((tophospitalList[index].title).validate(),
                          style: boldTextStyle())
                      .paddingOnly(left: 8.0),
                  4.height,
                  Text((tophospitalList[index].subtitle).validate(),
                          style: secondaryTextStyle())
                      .paddingOnly(left: 8.0),
                  10.height
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
