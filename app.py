# from flask import Flask, request, jsonify
# from keras.models import load_model
# from keras.preprocessing import image
# import numpy as np
# import os

# # Initialize the Flask application
# app = Flask(__name__)

# # Load the model
# try:
#     model = load_model('resnet50_cotton_model.h5')
# except Exception as e:
#     print(f"Error loading model: {e}")
#     exit(1)

# # Define the correct class labels based on your trained model
# class_labels = [
#     'diseased cotton leaf',
#     'diseased cotton plant',
#     'fresh cotton leaf',
#     'fresh cotton plant'
# ]

# # Define image upload folder
# UPLOAD_FOLDER = 'uploads'
# app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# # Make sure upload folder exists
# os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# # Define allowed image extensions
# ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# # Helper function to check allowed file extensions
# def allowed_file(filename):
#     return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# # Home route
# @app.route('/')
# def home():
#     return jsonify({
#         'message': 'Cotton Leaf Detector API',
#         'description': 'This is a cotton leaf classification service using ResNet50.',
#         'endpoint': '/detectdisease',
#         'method': 'POST',
#         'expected_input': 'An image file (PNG, JPG, JPEG, or GIF)'
#     })

# # Prediction route
# @app.route('/detectdisease', methods=['POST'])
# def detect_disease():
#     if 'file' not in request.files:
#         return jsonify({'error': 'No file part'}), 400
    
#     file = request.files['file']
    
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400
    
#     if file and allowed_file(file.filename):
#         try:
#             # Save the file
#             filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
#             file.save(filepath)

#             # Preprocess the image
#             img = image.load_img(filepath, target_size=(224, 224))
#             img_array = image.img_to_array(img)
#             img_array = np.expand_dims(img_array, axis=0)
#             img_array /= 255.0

#             # Make a prediction
#             predictions = model.predict(img_array)
#             predicted_class_idx = np.argmax(predictions, axis=1)[0]
            
#             if predicted_class_idx >= len(class_labels):
#                 return jsonify({'error': 'Prediction index out of range'}), 500
            
#             predicted_class = class_labels[predicted_class_idx]

#             # Return the predicted class and confidence
#             return jsonify({
#                 'yield_category': predicted_class,  # Match Flutter's expected key
#                 'class_index': int(predicted_class_idx),
#                 'confidence': float(predictions[0][predicted_class_idx])
#             }), 200

#         except Exception as e:
#             return jsonify({'error': f'Prediction failed: {str(e)}'}), 500
#         finally:
#             # Clean up the saved file
#             if os.path.exists(filepath):
#                 os.remove(filepath)

#     return jsonify({'error': 'Invalid file type'}), 400

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=8181, debug=True)












from flask import Flask, request, jsonify
from keras.models import load_model
from keras.preprocessing import image
import numpy as np
import os
import cv2
from collections import defaultdict

# Initialize the Flask application
app = Flask(__name__)

# Load the model
try:
    model = load_model('resnet50_cotton_model.h5')
except Exception as e:
    print(f"Error loading model: {e}")
    exit(1)

# Define the correct class labels based on your trained model
class_labels = [
    'diseased cotton leaf',
    'diseased cotton plant',
    'fresh cotton leaf',
    'fresh cotton plant'
]

# Define image upload folder
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Make sure upload folder exists
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Define allowed image extensions
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# Helper function to check allowed file extensions
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Function to check if image is predominantly non-cotton colors (updated threshold to 60%)
def is_non_cotton_image(img_path, threshold=0.60):  # Changed from 0.75 to 0.60
    # Read the image
    img = cv2.imread(img_path)
    if img is None:
        return False
    
    # Convert to HSV color space for better color detection
    hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    
    # Define color ranges (in HSV)
    # Black: value < 30
    lower_black = np.array([0, 0, 0])
    upper_black = np.array([180, 255, 30])
    
    # Blue: hue between 90 and 120
    lower_blue = np.array([90, 50, 50])
    upper_blue = np.array([120, 255, 255])
    
    # Red: hue either 0-10 or 170-180
    lower_red1 = np.array([0, 50, 50])
    upper_red1 = np.array([10, 255, 255])
    lower_red2 = np.array([170, 50, 50])
    upper_red2 = np.array([180, 255, 255])
    
    # Purple: hue between 120 and 150
    lower_purple = np.array([120, 50, 50])
    upper_purple = np.array([150, 255, 255])
    
    # Pink: hue between 150 and 170 (lower saturation)
    lower_pink = np.array([150, 30, 50])
    upper_pink = np.array([170, 255, 255])
    
    # Orange: hue between 10 and 25
    lower_orange = np.array([10, 50, 50])
    upper_orange = np.array([25, 255, 255])
    
    # Yellow: hue between 25 and 40 (but we'll limit to more intense yellows)
    lower_yellow = np.array([25, 70, 50])
    upper_yellow = np.array([40, 255, 255])
    
    # Brown: hue between 5 and 20, with low saturation and value
    lower_brown = np.array([5, 50, 20])
    upper_brown = np.array([20, 255, 100])
    
    # Create masks for each color
    mask_black = cv2.inRange(hsv, lower_black, upper_black)
    mask_blue = cv2.inRange(hsv, lower_blue, upper_blue)
    mask_red1 = cv2.inRange(hsv, lower_red1, upper_red1)
    mask_red2 = cv2.inRange(hsv, lower_red2, upper_red2)
    mask_red = cv2.bitwise_or(mask_red1, mask_red2)
    mask_purple = cv2.inRange(hsv, lower_purple, upper_purple)
    mask_pink = cv2.inRange(hsv, lower_pink, upper_pink)
    mask_orange = cv2.inRange(hsv, lower_orange, upper_orange)
    mask_yellow = cv2.inRange(hsv, lower_yellow, upper_yellow)
    mask_brown = cv2.inRange(hsv, lower_brown, upper_brown)
    
    # Combine all masks (excluding greens, whites, and clay-like colors)
    combined_mask = cv2.bitwise_or(mask_black, mask_blue)
    combined_mask = cv2.bitwise_or(combined_mask, mask_red)
    combined_mask = cv2.bitwise_or(combined_mask, mask_purple)
    combined_mask = cv2.bitwise_or(combined_mask, mask_pink)
    combined_mask = cv2.bitwise_or(combined_mask, mask_orange)
    combined_mask = cv2.bitwise_or(combined_mask, mask_yellow)
    combined_mask = cv2.bitwise_or(combined_mask, mask_brown)
    
    # Calculate percentage of image covered by these colors
    total_pixels = img.shape[0] * img.shape[1]
    colored_pixels = cv2.countNonZero(combined_mask)
    percentage = colored_pixels / total_pixels
    
    return percentage > threshold  # Now using 60% threshold

# Home route
@app.route('/')
def home():
    return jsonify({
        'message': 'Cotton Leaf Detector API',
        'description': 'This is a cotton leaf classification service using ResNet50.',
        'endpoint': '/detectdisease',
        'method': 'POST',
        'expected_input': 'An image file (PNG, JPG, JPEG, or GIF)',
        'color_check': 'Rejects images with >60% non-cotton colors (black, blue, red, purple, pink, orange, yellow, brown)'  # Updated documentation
    })

# Prediction route
@app.route('/detectdisease', methods=['POST'])
def detect_disease():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    
    file = request.files['file']
    
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    
    if file and allowed_file(file.filename):
        try:
            # Save the file
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
            file.save(filepath)
            
            # Check if image is predominantly non-cotton colors (now 60%)
            if is_non_cotton_image(filepath):
                return jsonify({
                    'error': 'This image appears to be predominantly non-cotton colors (black, blue, red, purple, pink, orange, yellow, or brown) and is likely not a cotton-related image',
                    'is_non_cotton': True
                }), 400

            # Preprocess the image
            img = image.load_img(filepath, target_size=(224, 224))
            img_array = image.img_to_array(img)
            img_array = np.expand_dims(img_array, axis=0)
            img_array /= 255.0

            # Make a prediction
            predictions = model.predict(img_array)
            predicted_class_idx = np.argmax(predictions, axis=1)[0]
            
            if predicted_class_idx >= len(class_labels):
                return jsonify({'error': 'Prediction index out of range'}), 500
            
            predicted_class = class_labels[predicted_class_idx]

            # Return the predicted class and confidence
            return jsonify({
                'yield_category': predicted_class,
                'class_index': int(predicted_class_idx),
                'confidence': float(predictions[0][predicted_class_idx]),
                'is_non_cotton': False
            }), 200

        except Exception as e:
            return jsonify({'error': f'Prediction failed: {str(e)}'}), 500
        finally:
            # Clean up the saved file
            if os.path.exists(filepath):
                os.remove(filepath)

    return jsonify({'error': 'Invalid file type'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8181, debug=True)








# from flask import Flask, request, jsonify
# from keras.models import load_model
# from keras.preprocessing import image
# import numpy as np
# import os
# import cv2
# from collections import defaultdict

# # Initialize the Flask application
# app = Flask(__name__)

# # Load the model
# try:
#     model = load_model('resnet50_cotton_model.h5')
# except Exception as e:
#     print(f"Error loading model: {e}")
#     exit(1)

# # Define the correct class labels based on your trained model
# class_labels = [
#     'diseased cotton leaf',
#     'diseased cotton plant',
#     'fresh cotton leaf',
#     'fresh cotton plant'
# ]

# # Define image upload folder
# UPLOAD_FOLDER = 'uploads'
# app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# # Make sure upload folder exists
# os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# # Define allowed image extensions
# ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# # Helper function to check allowed file extensions
# def allowed_file(filename):
#     return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# # Function to check if image is predominantly non-cotton colors
# def is_non_cotton_image(img_path, threshold=0.75):
#     # Read the image
#     img = cv2.imread(img_path)
#     if img is None:
#         return False
    
#     # Convert to HSV color space for better color detection
#     hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    
#     # Define color ranges (in HSV)
#     # Black: value < 30
#     lower_black = np.array([0, 0, 0])
#     upper_black = np.array([180, 255, 30])
    
#     # Blue: hue between 90 and 120
#     lower_blue = np.array([90, 50, 50])
#     upper_blue = np.array([120, 255, 255])
    
#     # Red: hue either 0-10 or 170-180
#     lower_red1 = np.array([0, 50, 50])
#     upper_red1 = np.array([10, 255, 255])
#     lower_red2 = np.array([170, 50, 50])
#     upper_red2 = np.array([180, 255, 255])
    
#     # Purple: hue between 120 and 150
#     lower_purple = np.array([120, 50, 50])
#     upper_purple = np.array([150, 255, 255])
    
#     # Pink: hue between 150 and 170 (lower saturation)
#     lower_pink = np.array([150, 30, 50])
#     upper_pink = np.array([170, 255, 255])
    
#     # Orange: hue between 10 and 25
#     lower_orange = np.array([10, 50, 50])
#     upper_orange = np.array([25, 255, 255])
    
#     # Yellow: hue between 25 and 40 (but we'll limit to more intense yellows)
#     lower_yellow = np.array([25, 70, 50])
#     upper_yellow = np.array([40, 255, 255])
    
#     # Brown: hue between 5 and 20, with low saturation and value
#     lower_brown = np.array([5, 50, 20])
#     upper_brown = np.array([20, 255, 100])
    
#     # Create masks for each color
#     mask_black = cv2.inRange(hsv, lower_black, upper_black)
#     mask_blue = cv2.inRange(hsv, lower_blue, upper_blue)
#     mask_red1 = cv2.inRange(hsv, lower_red1, upper_red1)
#     mask_red2 = cv2.inRange(hsv, lower_red2, upper_red2)
#     mask_red = cv2.bitwise_or(mask_red1, mask_red2)
#     mask_purple = cv2.inRange(hsv, lower_purple, upper_purple)
#     mask_pink = cv2.inRange(hsv, lower_pink, upper_pink)
#     mask_orange = cv2.inRange(hsv, lower_orange, upper_orange)
#     mask_yellow = cv2.inRange(hsv, lower_yellow, upper_yellow)
#     mask_brown = cv2.inRange(hsv, lower_brown, upper_brown)
    
#     # Combine all masks (excluding greens, whites, and clay-like colors)
#     combined_mask = cv2.bitwise_or(mask_black, mask_blue)
#     combined_mask = cv2.bitwise_or(combined_mask, mask_red)
#     combined_mask = cv2.bitwise_or(combined_mask, mask_purple)
#     combined_mask = cv2.bitwise_or(combined_mask, mask_pink)
#     combined_mask = cv2.bitwise_or(combined_mask, mask_orange)
#     combined_mask = cv2.bitwise_or(combined_mask, mask_yellow)
#     combined_mask = cv2.bitwise_or(combined_mask, mask_brown)
    
#     # Calculate percentage of image covered by these colors
#     total_pixels = img.shape[0] * img.shape[1]
#     colored_pixels = cv2.countNonZero(combined_mask)
#     percentage = colored_pixels / total_pixels
    
#     return percentage > threshold

# # Home route
# @app.route('/')
# def home():
#     return jsonify({
#         'message': 'Cotton Leaf Detector API',
#         'description': 'This is a cotton leaf classification service using ResNet50.',
#         'endpoint': '/detectdisease',
#         'method': 'POST',
#         'expected_input': 'An image file (PNG, JPG, JPEG, or GIF)',
#         'color_check': 'Rejects images with >75% non-cotton colors (black, blue, red, purple, pink, orange, yellow, brown)'
#     })

# # Prediction route
# @app.route('/detectdisease', methods=['POST'])
# def detect_disease():
#     if 'file' not in request.files:
#         return jsonify({'error': 'No file part'}), 400
    
#     file = request.files['file']
    
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400
    
#     if file and allowed_file(file.filename):
#         try:
#             # Save the file
#             filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
#             file.save(filepath)
            
#             # Check if image is predominantly non-cotton colors
#             if is_non_cotton_image(filepath):
#                 return jsonify({
#                     'error': 'This image appears to be predominantly non-cotton colors (black, blue, red, purple, pink, orange, yellow, or brown) and is likely not a cotton-related image',
#                     'is_non_cotton': True
#                 }), 400

#             # Preprocess the image
#             img = image.load_img(filepath, target_size=(224, 224))
#             img_array = image.img_to_array(img)
#             img_array = np.expand_dims(img_array, axis=0)
#             img_array /= 255.0

#             # Make a prediction
#             predictions = model.predict(img_array)
#             predicted_class_idx = np.argmax(predictions, axis=1)[0]
            
#             if predicted_class_idx >= len(class_labels):
#                 return jsonify({'error': 'Prediction index out of range'}), 500
            
#             predicted_class = class_labels[predicted_class_idx]

#             # Return the predicted class and confidence
#             return jsonify({
#                 'yield_category': predicted_class,
#                 'class_index': int(predicted_class_idx),
#                 'confidence': float(predictions[0][predicted_class_idx]),
#                 'is_non_cotton': False
#             }), 200

#         except Exception as e:
#             return jsonify({'error': f'Prediction failed: {str(e)}'}), 500
#         finally:
#             # Clean up the saved file
#             if os.path.exists(filepath):
#                 os.remove(filepath)

#     return jsonify({'error': 'Invalid file type'}), 400

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=8181, debug=True)


