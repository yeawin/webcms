#coding: utf-8 
from django.db import models

# Create your models here.
class subject(models.Model):
	subject_name_zh = models.CharField(max_length=255, null=False, help_text='栏目名')
	subject_name_en = models.CharField(max_length=255, null=False, help_text='栏目名')
	parent = models.IntegerField(null=False, help_text='父栏目')
	order = models.IntegerField(null=True, default=0, help_text='排序')
	is_visiable = models.BooleanField(default=0, help_text='是否显示')
	is_removed = models.BooleanField(default=0, help_text='是否删除')