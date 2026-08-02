package com.cyberaudit.api.service.impl;

import com.cyberaudit.api.entity.Usuario;
import com.cyberaudit.api.exception.ResourceNotFoundException;
import com.cyberaudit.api.repository.UsuarioRepository;
import com.cyberaudit.api.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    @Override
    public Usuario buscarPorId(Integer id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No se encontro el usuario con id " + id));
    }

    @Override
    public Usuario crear(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizar(Integer id, Usuario datosNuevos) {
        Usuario existente = buscarPorId(id);
        existente.setNombre(datosNuevos.getNombre());
        existente.setCorreo(datosNuevos.getCorreo());
        existente.setContrasena(datosNuevos.getContrasena());
        existente.setIdRol(datosNuevos.getIdRol());
        return usuarioRepository.save(existente);
    }

    @Override
    public void eliminar(Integer id) {
        Usuario existente = buscarPorId(id);
        usuarioRepository.delete(existente);
    }
}
