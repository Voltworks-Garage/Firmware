#!/usr/bin/env python3
"""
Test runner script for all CAN tool tests.
Runs all test files in the tests directory and provides a summary.
"""

import os
import sys
import importlib.util
import traceback

def run_test_file(test_file):
    """Run a single test file and return success status"""
    try:
        print(f"\n{'='*50}")
        print(f"Running {test_file}...")
        print('='*50)
        
        # Load and execute the test module
        spec = importlib.util.spec_from_file_location("test_module", test_file)
        test_module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(test_module)
        
        # Look for a main function or test function to call
        if hasattr(test_module, 'main'):
            test_module.main()
        elif hasattr(test_module, 'test_' + os.path.basename(test_file)[5:-3]):
            # Try to call a function named after the file
            test_func_name = 'test_' + os.path.basename(test_file)[5:-3]
            if hasattr(test_module, test_func_name):
                getattr(test_module, test_func_name)()
        
        print(f"✅ {test_file} completed successfully")
        return True
        
    except Exception as e:
        print(f"❌ {test_file} failed: {e}")
        print(f"Traceback: {traceback.format_exc()}")
        return False

def main():
    """Run all test files in the current directory"""
    test_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Find all test files
    test_files = [f for f in os.listdir(test_dir) 
                  if f.startswith('test_') and f.endswith('.py')]
    
    print(f"Found {len(test_files)} test files:")
    for test_file in test_files:
        print(f"  • {test_file}")
    
    # Run each test
    results = {}
    for test_file in sorted(test_files):
        test_path = os.path.join(test_dir, test_file)
        results[test_file] = run_test_file(test_path)
    
    # Print summary
    print(f"\n{'='*60}")
    print("TEST SUMMARY")
    print('='*60)
    
    passed = sum(results.values())
    failed = len(results) - passed
    
    for test_file, success in results.items():
        status = "✅ PASS" if success else "❌ FAIL"
        print(f"{status:8} {test_file}")
    
    print(f"\nTotal: {len(results)} tests")
    print(f"Passed: {passed}")
    print(f"Failed: {failed}")
    
    if failed == 0:
        print("\n🎉 All tests passed!")
        return 0
    else:
        print(f"\n⚠️  {failed} test(s) failed")
        return 1

if __name__ == "__main__":
    sys.exit(main())