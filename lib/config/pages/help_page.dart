import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildScanningRecipt(context),
                SizedBox(height: 10.h),
                _buildGeneratingRecipe(context),
                SizedBox(height: 10.h),
                _buildSavingGeneratedRecipe(context),
                SizedBox(height: 10.h),
                _buildFridgeItemsManagement(context),
                SizedBox(height: 10.h),
                _buildSavedRecipesManagement(context),
                SizedBox(height: 10.h),
                _buildSharingRecipe(context),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildScanningRecipt(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        'Scanning Recipt',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '1. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Upload or capture a receipt image',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '2. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'Review scanned items: add missing \nitems, correct details, and remove errors.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '3. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Select items to add to fridge inventory.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '4. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Save and verify items in fridge \n    inventory page.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  _buildGeneratingRecipe(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        'Generating Recipe',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '1. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Select food items from your fridge.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '2. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'Press the "Generate Recipes" button at the bottom right.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '3. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Select the desired recipe cuisine.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '4. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Wait for Gemini to generate five recipes.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '5. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Swipe left to check out all generated recipes.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  _buildSavingGeneratedRecipe(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        'Saving Generated Recipe',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '1. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'After recipes are generated, press the bookmark icon at the top right to save.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '2. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Press the bookmark icon again to undo the save.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  _buildFridgeItemsManagement(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        'Fridge Items Management',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '1. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'Edit item information by pressing the pencil icon or swiping left and pressing the edit button.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '2. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'Remove used or expired items by pressing the trash bin icon or swiping left and pressing delete.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '3. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'Add new items by pressing the "+" icon in the top right.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  _buildSavedRecipesManagement(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        'Saved Recipe Management',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '1. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: 'Access saved recipes from the Recipes page.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '2. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'To remove a saved recipe, select the recipe to open its details page, then press the trash bin icon at the top right.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '3. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text:
                    'Search saved recipes by pressing the search icon at the top right of the My Recipes page.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  _buildSharingRecipe(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      childrenPadding: EdgeInsets.symmetric(horizontal: 6.w),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        'Share Recipe',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: '1. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '2. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: '3. ',
            style: Theme.of(context).textTheme.headlineLarge,
            children: [
              TextSpan(
                text: '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
