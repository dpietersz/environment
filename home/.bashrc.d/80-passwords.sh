# 80-passwords.sh — API keys from pass

if command -v pass &>/dev/null; then
	export ANTHROPIC_API_KEY=$(pass show Sites/anthropic.com/PAT/neovim)
	export OPENAI_API_KEY=$(pass show Sites/openai.com/api-keys/neovim)
	export OPENAI_KEY=$OPENAI_API_KEY
	export GEMINI_API_KEY=$(pass show Sites/google.com/PAT/dividendportfoliomanager.com)
	export GOOGLE_AI_API_KEY=$GEMINI_API_KEY
	export DATABRICKS_HOST="https://adb-5244239616138753.13.azuredatabricks.net"
	export DATABRICKS_SECRET=$(pass show Logins/gemeente-hilversum/databricks/service-principal | grep -m 1 '^')
	export DATABRICKS_CLIENT_ID=$(pass show Logins/gemeente-hilversum/databricks/service-principal | grep "client-id:" | cut -d ' ' -f 2)
	export OPENROUTER_API_KEY=$(pass show Sites/openrouter.ai/api-keys/aider)
	export DEEPSEEK_API_KEY=$(pass show Sites/deepseek.com/api-key/aider)
else
	echo "Install pass to load API keys securely."
fi

