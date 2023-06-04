from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Model for registration form data
class RegistrationForm(BaseModel):
    username: str
    email: str
    password: str

# Registration endpoint
@app.post('/register')
def register(registration_form: RegistrationForm):
    # Process the registration form data
    # You can perform database operations or any other necessary actions here
    # Example: Save the user to the database
    # db.save_user(registration_form.username, registration_form.email, registration_form.password)

    # Return a response
    return {'message': 'User registration successful'}