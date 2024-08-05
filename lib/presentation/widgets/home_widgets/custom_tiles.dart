import '../../consts/consts.dart';

Widget customTiles(
    {required String title, required String value, required String unit}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(smallBorderRadius),
        color: Colors.white24,
        border: Border.all()),
    child: ListTile(
      title: Text(title,
          style: const TextStyle(
              fontSize: mediumFont,
              color: white,
              fontFamily: poppins,
              fontWeight: FontWeight.w600)),
      trailing: Text('$value $unit',
          style: const TextStyle(
              fontSize: mediumFont,
              color: white,
              fontFamily: poppins,
              fontWeight: FontWeight.w500)),
    ),
  );
}
