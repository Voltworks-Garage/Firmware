#!/usr/bin/env python3
"""
Setup script for CAN Tool
"""

from setuptools import setup, find_packages

with open("README_MODULAR.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="can-tool",
    version="1.0.0",
    author="Voltworks Garage", 
    description="Modular CAN bus analysis tool with plugin support",
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Embedded Systems",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
    python_requires=">=3.7",
    install_requires=[
        "python-can>=4.0.0",
    ],
    extras_require={
        "gui": ["tkinter"],  # Usually included with Python
    },
    entry_points={
        "console_scripts": [
            "can-tool=can_tool.main:main",
        ],
    },
)