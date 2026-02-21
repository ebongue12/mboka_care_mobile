import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/error_handler.dart';

enum DocumentsStatus { initial, loading, loaded, error, uploading }

class DocumentModel {
  final String id;
  final String title;
  final String documentType;
  final String fileUrl;
  final DateTime uploadedAt;

  DocumentModel({
    required this.id,
    required this.title,
    required this.documentType,
    required this.fileUrl,
    required this.uploadedAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      title: json['title'],
      documentType: json['document_type'],
      fileUrl: json['file_url'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }
}

class DocumentsState {
  final DocumentsStatus status;
  final List<DocumentModel> documents;
  final String? errorMessage;
  final double? uploadProgress;

  DocumentsState({
    required this.status,
    this.documents = const [],
    this.errorMessage,
    this.uploadProgress,
  });

  DocumentsState copyWith({
    DocumentsStatus? status,
    List<DocumentModel>? documents,
    String? errorMessage,
    double? uploadProgress,
  }) {
    return DocumentsState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      errorMessage: errorMessage,
      uploadProgress: uploadProgress,
    );
  }
}

class DocumentsNotifier extends StateNotifier<DocumentsState> {
  final ApiClient _apiClient;

  DocumentsNotifier(this._apiClient)
      : super(DocumentsState(status: DocumentsStatus.initial));

  Future<void> loadDocuments() async {
    state = state.copyWith(status: DocumentsStatus.loading);
    try {
      final response = await _apiClient.getDocuments();
      if (response.statusCode == 200) {
        final List<DocumentModel> documents =
            (response.data['results'] as List)
                .map((json) => DocumentModel.fromJson(json))
                .toList();
        state = state.copyWith(
          status: DocumentsStatus.loaded,
          documents: documents,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: DocumentsStatus.error,
        errorMessage: ErrorHandler.getMessage(e),
      );
    }
  }

  Future<bool> uploadDocument({
    required String filePath,
    required String title,
    required String documentType,
  }) async {
    state = state.copyWith(
      status: DocumentsStatus.uploading,
      uploadProgress: 0.0,
    );

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        'title': title,
        'document_type': documentType,
      });

      final response = await _apiClient.uploadDocument(formData);

      if (response.statusCode == 201) {
        await loadDocuments();
        state = state.copyWith(uploadProgress: 1.0);
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(
        status: DocumentsStatus.error,
        errorMessage: ErrorHandler.getMessage(e),
      );
      return false;
    }
  }

  Future<bool> deleteDocument(String id) async {
    try {
      final response = await _apiClient.deleteDocument(id);
      if (response.statusCode == 204) {
        await loadDocuments();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

final documentsProvider =
    StateNotifierProvider<DocumentsNotifier, DocumentsState>((ref) {
  return DocumentsNotifier(ApiClient());
});
