import '/flutter_flow/flutter_flow_model.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../services/profile_service.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> with ChangeNotifier {
  UserProfile? userProfile;
  bool isLoading = true;
  bool isOwner = true;

  @override
  void initState(BuildContext context) {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    if (!isLoading) return;
    
    try {
      userProfile = await ProfileService.getUserProfile();
    } catch (e) {
      print('Error loading profile: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
