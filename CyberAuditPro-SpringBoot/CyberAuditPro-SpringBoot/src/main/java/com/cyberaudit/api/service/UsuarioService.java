package com.cyberaudit.api.service;

import com.cyberaudit.api.entity.Usuario;

import java.util.List;

public interface UsuarioService {
    List<Usuario> listarTodos();

    Usuario buscarPorId(Integer id);

    Usuario crear(Usuario usuario);

    Usuario actualizar(Integer id, Usuario usuario);

    void eliminar(Integer id);
}
