import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../services/profile_service.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  UserProfile? userProfile;
  bool isLoading = true;
  bool isOwner = true; // Para controlar se é o próprio usuário

  @override
  void initState(BuildContext context) {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      userProfile = await ProfileService.getUserProfile();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {}
}
