local M = {}

local function get_symbols(kind)
	local params = { textDocument = vim.lsp.util.make_text_document_params() }
	local results = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1000)
	if not results then return {} end

	local ranges = {}
	for _, resp in pairs(results) do
		for _, symbol in ipairs(resp.result or {}) do
			if symbol.kind == kind then
				local start_line = symbol.range.start.line + 1
				local start_col = symbol.range.start.character + 1
				local end_line = symbol.range["end"].line + 1
				local end_col = symbol.range["end"].character + 1
				table.insert(ranges, {start_line, start_col, end_line, end_col})
			end
		end
	end
	return ranges
end

function M.functions()
	return get_symbols(12) 
end

function M.classes()
	return get_symbols(5) 
end

return M
