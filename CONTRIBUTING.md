# Contributing to AzureDoc

Thank you for your interest in contributing to AzureDoc! This document provides guidelines and instructions for contributing to this project.

## How to Contribute

### Reporting Issues

If you find a bug or have a suggestion for improvement:

1. Check if the issue already exists in the [Issues](https://github.com/fabioharams/AzureDoc/issues) section
2. If not, create a new issue with:
   - A clear, descriptive title
   - Detailed description of the issue or enhancement
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Your environment details (OS, Azure CLI version, etc.)

### Contributing Code

1. **Fork the Repository**
   ```bash
   # Fork the repo on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/AzureDoc.git
   cd AzureDoc
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

3. **Make Your Changes**
   - Follow the existing code style
   - Add comments for complex logic
   - Update documentation as needed
   - Test your changes thoroughly

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

5. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your fork and branch
   - Provide a clear description of your changes
   - Link any related issues

## Code Style Guidelines

### Bash Scripts
- Use meaningful variable names in UPPER_CASE
- Add comments for complex sections
- Use `set -e` to exit on errors
- Include error handling
- Follow shellcheck recommendations

### PowerShell Scripts
- Use PascalCase for function names
- Use approved verbs (Get-, Set-, New-, etc.)
- Add comment-based help for functions
- Include error handling with try-catch blocks

### Python Scripts
- Follow PEP 8 style guide
- Use type hints where appropriate
- Add docstrings to functions and classes
- Use meaningful variable names
- Include error handling

### Markdown Documentation
- Use clear, concise language
- Include code examples where relevant
- Add links to external resources
- Use proper heading hierarchy (H1 → H2 → H3)
- Include emojis for visual appeal (sparingly)

## Documentation Standards

When updating documentation:

1. **Be Clear and Concise**
   - Use simple language
   - Avoid jargon unless necessary
   - Define technical terms

2. **Include Examples**
   - Provide working code samples
   - Show expected output
   - Include error scenarios

3. **Keep It Updated**
   - Update documentation when changing code
   - Verify all commands and code samples work
   - Check all links are valid

4. **Structure Logically**
   - Use clear headings
   - Group related information
   - Add table of contents for long documents

## Testing

Before submitting your contribution:

1. **Test Your Scripts**
   ```bash
   # Test bash scripts
   shellcheck examples/scripts/generate-docs.sh
   bash -n examples/scripts/generate-docs.sh
   
   # Test Python scripts
   python -m py_compile examples/scripts/azure_doc_generator.py
   pylint examples/scripts/azure_doc_generator.py
   ```

2. **Test Documentation**
   - Verify all commands work
   - Check all links are valid
   - Ensure code blocks have proper syntax highlighting

3. **Test in a Clean Environment**
   - Clone your fork in a new directory
   - Follow the setup instructions from scratch
   - Verify everything works as documented

## Adding New Features

When adding new features:

1. **Check Existing Issues**
   - Look for similar feature requests
   - Discuss your idea in an issue first

2. **Keep It Modular**
   - Create separate functions/scripts
   - Make features optional when possible
   - Don't break existing functionality

3. **Document Thoroughly**
   - Update README.md
   - Add examples
   - Update relevant templates

4. **Consider Backwards Compatibility**
   - Don't break existing scripts
   - Deprecate features gradually
   - Provide migration guides

## Adding New Templates

To add a new documentation template:

1. Create the template file in `examples/templates/`
2. Use placeholders in [BRACKETS]
3. Include all relevant sections
4. Add usage instructions to README.md
5. Provide an example of filled-out template

## Improving Scripts

When improving scripts:

1. **Maintain Compatibility**
   - Don't break existing usage patterns
   - Add new features as optional parameters

2. **Add Error Handling**
   - Check for required tools/dependencies
   - Provide helpful error messages
   - Exit gracefully on errors

3. **Improve Output**
   - Make output readable
   - Add progress indicators
   - Use colors/formatting appropriately

4. **Optimize Performance**
   - Reduce API calls where possible
   - Cache results when appropriate
   - Parallelize when safe

## GitHub Copilot Tips for Contributors

When using GitHub Copilot to contribute:

1. **Be Specific in Prompts**
   ```
   Good: "Create a function to list Azure SQL databases with their 
   tier, size, and backup retention in Markdown table format"
   
   Bad: "Make a database function"
   ```

2. **Review AI Suggestions**
   - Don't accept code blindly
   - Verify it follows project patterns
   - Test thoroughly

3. **Use Copilot Chat**
   - Ask for explanations
   - Request optimizations
   - Get help with Azure CLI syntax

4. **Iterate and Refine**
   - Start with basic implementation
   - Ask Copilot to enhance
   - Add error handling
   - Improve documentation

## Code Review Process

All contributions go through code review:

1. **Automated Checks**
   - Syntax validation
   - Linting
   - Link checking

2. **Manual Review**
   - Code quality
   - Documentation accuracy
   - Security considerations
   - Best practices adherence

3. **Feedback**
   - Address review comments
   - Update your PR as needed
   - Be open to suggestions

## Security Considerations

When contributing:

- ⚠️ **Never commit credentials or secrets**
- ⚠️ **Don't expose sensitive Azure information**
- ⚠️ **Sanitize example outputs**
- ✅ Use environment variables for sensitive data
- ✅ Include security best practices in documentation
- ✅ Review `.gitignore` to exclude sensitive files

## Recognition

Contributors will be recognized in:
- The repository's contributors list
- Release notes (for significant contributions)
- The README.md (for major features)

## Questions?

If you have questions:
- Open an issue with the "question" label
- Reach out to the maintainers
- Check existing documentation and issues first

## License

By contributing to AzureDoc, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to AzureDoc! 🎉
