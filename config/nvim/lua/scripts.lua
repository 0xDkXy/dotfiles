vim.keymap.set('n', 'gd', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local encoding = clients[1] and clients[1].offset_encoding or "utf-8"
  local params = vim.lsp.util.make_position_params(0, encoding)

  vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result, _, _)
    if not result then return end
    local locations = type(result) == 'table' and result or { result }

    local function is_header(uri)
      return uri:match('%.h$') or uri:match('%.hpp$') or uri:match('%.hxx$')
    end

    local function is_source(uri)
      return uri:match('%.c$') or uri:match('%.cc$') or uri:match('%.cpp$') or uri:match('%.cxx$')
    end

    -- Try to pick the best location: source file > non-header > fallback
    local preferred = nil
    for _, loc in ipairs(locations) do
      local uri = loc.uri or loc.targetUri
      if uri and is_source(uri) then
        preferred = loc
        break
      end
    end

    if not preferred then
      for _, loc in ipairs(locations) do
        local uri = loc.uri or loc.targetUri
        if uri and not is_header(uri) then
          preferred = loc
          break
        end
      end
    end

    preferred = preferred or locations[1]
    vim.lsp.util.show_document(preferred, encoding, { reuse_win = true, focus = true })
  end)
end, { desc = "Go to definition (smart jump to source)" })

