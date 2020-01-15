from django.contrib import admin
from .models import Profile
from django.contrib.admin.templatetags.admin_list import admin_actions

admin.site.register(Profile)
# Register your models here.
