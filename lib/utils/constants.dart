import 'package:flutter/material.dart';

Color mPrimaryColor = Color(0xFF166DE0);
Color mConfirmedColor = Color(0xFFFF1242);
Color mActiveColor = Color(0xFF017BFF);
Color mRecoveredColor = Color(0xFF29A746);
Color mDeathColor = Color(0xFF6D757D);

LinearGradient mGradientShimmer = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Colors.grey[300], Colors.grey[100]],
);
