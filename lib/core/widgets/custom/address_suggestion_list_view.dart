import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/core/widgets/custom/loading_overlay.dart';
import '../../../api/model/static/google_place_model.dart';
import '../../../pages/preference/google_place_service.dart';
import '../../themes/app_colors.dart';
import '../../utils/app_logger.dart';

class AddressSuggestionListView extends StatelessWidget {
  final double? listHeight;
  final List<GooglePlaceModel> locationList;
  final CancelToken? cancelToken;
  final void Function(GooglePlaceModel googlePlaceModel)? onTapPlace;
  final bool isLoading;

  const AddressSuggestionListView({
    super.key,
    this.listHeight,
    this.cancelToken,
    required this.locationList,
    this.onTapPlace,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: locationList.isEmpty && !isLoading
          ? const SizedBox.shrink()
          : Card(
        margin: const EdgeInsets.only(top: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: listHeight ?? 300,
          ),
          child: Column(
            children: [
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: locationList.length,
                    itemBuilder: (context, index) {
                      final place = locationList[index];
                      return _buildSuggestionItem(context, place);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      indent: 48,
                      endIndent: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(BuildContext context, GooglePlaceModel place) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final loadingOverlay = LoadingOverlay.of(context);
          try {
            loadingOverlay.show(context);

            final detailedPlace = await GooglePlaceService.getPlaceDetails(
              googlePlaceModel: place,
              cancelToken: cancelToken,
            );

            loadingOverlay.hide();

            if (detailedPlace.shortAddressName.isNotEmpty) {
              onTapPlace?.call(detailedPlace);
            }
          } catch (e) {
            scaffoldMessenger.showSnackBar(
              SnackBar(content: Text('Failed to load place details: ${e.toString()}')),
            );
          }
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (place.formattedAddress.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          place.formattedAddress,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
