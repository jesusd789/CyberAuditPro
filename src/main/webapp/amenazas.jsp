<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CYBERAUDIT PRO — Amenazas</title>
  <link rel="stylesheet" href="cyberaudit.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <style>
    .table-toolbar { display: flex; align-items: center; gap: 12px; padding: 14px 0; margin-bottom: 6px; flex-wrap: wrap; }
    .toolbar-count { display: flex; align-items: center; gap: 8px; font-family: var(--font-mono); font-size: 12px; color: var(--text2); }
    .toolbar-count i { color: var(--cyan); }
    .toolbar-badges { margin-left: auto; display: flex; gap: 6px; }
    .count-badge { padding: 4px 12px; border-radius: 5px; font-family: var(--font-mono); font-size: 10px; font-weight: 700; }
    .count-badge.critical { background:#ff335520; color:var(--red);    border:1px solid #ff335535; }
    .count-badge.high     { background:#ff8c0020; color:var(--orange); border:1px solid #ff8c0035; }
    .count-badge.medium   { background:#ffc10720; color:var(--yellow); border:1px solid #ffc10735; }

    .file-path { font-family: var(--font-mono); font-size: 11px; color: var(--text); }
    .device-cell { line-height: 1.4; }
    .device-name { font-weight: 600; }
    .device-ip { font-family: var(--font-mono); font-size: 10px; color: var(--text2); }

    .action-wrap { display: flex; gap: 6px; flex-wrap: wrap; }
    .btn-eliminar, .btn-restaurar, .btn-cuarentena {
      padding: 5px 12px; border-radius: 5px;
      font-family: var(--font-mono); font-size: 10px; font-weight: 700;
      cursor: pointer; display: flex; align-items: center; gap: 4px;
      border: 1px solid transparent; transition: all 0.18s; text-decoration: none;
    }
    .btn-eliminar   { background: #ff335518; color: var(--red);    border-color: #ff335535; }
    .btn-eliminar:hover   { background: var(--red); color: #fff; }
    .btn-restaurar  { background: #17c3f518; color: var(--cyan);   border-color: #17c3f535; }
    .btn-restaurar:hover  { background: var(--cyan); color: #000; }
    .btn-cuarentena { background: #ff8c0018; color: var(--orange); border-color: #ff8c0035; }
    .btn-cuarentena:hover { background: var(--orange); color: #000; }

    /* Formulario de registro */
    .form-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
    .form-group label {
      display: block; margin-bottom: 6px;
      font-family: var(--font-mono); font-size: 11px; color: var(--text2);
    }
    .form-group input, .form-group select {
      width: 100%; padding: 9px 10px;
      background: var(--bg-input); border: 1px solid var(--border);
      border-radius: 6px; color: var(--text); font-size: 12px;
    }
    .form-group input:focus, .form-group select:focus { outline: none; border-color: var(--cyan); }
    .form-actions { grid-column: span 3; text-align: right; margin-top: 4px; }
    @media (max-width: 900px) { .form-grid { grid-template-columns: 1fr; } .form-actions { grid-column: span 1; } }
  </style>
</head>
<body>
<div class="app">

  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sidebar-brand">
      <div class="brand-icon"><i class="fa-solid fa-shield-halved"></i></div>
      <div class="brand-text">
        <div class="brand-name">CYBERAUDIT</div>
        <div class="brand-ver">PRO v2.4.1</div>
      </div>
    </div>
    <div class="sidebar-status">
      <div class="status-row"><span class="dot dot-green"></span> Sistema Operativo</div>
      <div class="status-row"><span class="dot dot-cyan"></span> Monitoreo Activo</div>
    </div>
    <div class="sidebar-section-label">Módulos</div>
    <nav>
      <a href="dashboard.html" class="nav-item">
        <i class="fa-solid fa-chart-line"></i> Dashboard <span class="rf-badge">RF2</span>
      </a>
      <a href="escaneo.html" class="nav-item">
        <i class="fa-solid fa-radar"></i> Escaneo <span class="rf-badge">RF3</span>
      </a>
      <a href="Controlador?accion=listar" class="nav-item active">
        <i class="fa-solid fa-triangle-exclamation"></i> Amenazas <span class="rf-badge rf-red">RF5</span>
      </a>
      <a href="reportes.html" class="nav-item">
        <i class="fa-regular fa-file-lines"></i> Reportes <span class="rf-badge rf-green">RF6</span>
      </a>
      <a href="network.html" class="nav-item">
        <i class="fa-solid fa-network-wired"></i> Red / Firewall <span class="rf-badge rf-purple">RF7</span>
      </a>
    </nav>
    <div class="sidebar-footer">
      <div class="sidebar-user">admin@cyberaudit.com</div>
      <button class="btn-logout" onclick="location.href='index.html'">
        <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
      </button>
    </div>
  </aside>

  <!-- TOPBAR -->
  <header class="topbar">
    <div class="topbar-path">
      <span class="prompt">&gt;</span>
      <span class="path">/threats</span>
      <span class="rf-badge rf-red">RF5</span>
    </div>
    <div class="topbar-spacer"></div>
    <div class="topbar-status">
      <span class="online-dot"></span><span>EN LÍNEA</span>
    </div>
    <div class="topbar-time">
      <i class="fa-regular fa-clock"></i>
      <span id="clock">--:--:--</span>
    </div>
  </header>

  <!-- CONTENT -->
  <main class="content" style="overflow-y:auto;">
    <div class="page-title">
      Gestión de Amenazas / Cuarentena
      <span class="rf-badge rf-red" style="font-size:11px;vertical-align:middle;">RF5</span>
    </div>

    <!-- Formulario CREATE -->
    <div class="card mb-16">
      <div class="card-title"><i class="fa-solid fa-shield-virus"></i> Registrar nueva amenaza detectada</div>
      <form action="Controlador" method="POST" class="form-grid mt-16">
        <input type="hidden" name="accion" value="Guardar">

        <div class="form-group">
          <label>Dispositivo afectado</label>
          <select name="txtDispositivo" required>
            <c:forEach var="d" items="${listaDispositivos}">
              <option value="${d.id}">${d.nombreHost} (${d.direccionIp})</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label>Ruta del archivo</label>
          <input type="text" name="txtArchivo" placeholder="/tmp/archivo_sospechoso.sh" required>
        </div>

        <div class="form-group">
          <label>Tipo de malware</label>
          <input type="text" name="txtTipo" placeholder="Trojan, Ransomware, Spyware..." required>
        </div>

        <div class="form-group">
          <label>Nivel de riesgo</label>
          <select name="txtRiesgo" required>
            <option value="critical">Crítico</option>
            <option value="high">Alto</option>
            <option value="medium">Medio</option>
            <option value="low">Bajo</option>
          </select>
        </div>

        <div class="form-group">
          <label>Tamaño del archivo</label>
          <input type="text" name="txtTamano" placeholder="Ej: 1.4 MB" required>
        </div>

        <div class="form-group">
          <label>Fecha de detección</label>
          <input type="datetime-local" name="txtFecha" required>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-cyan">
            <i class="fa-solid fa-plus"></i> Añadir a cuarentena
          </button>
        </div>
      </form>
    </div>

    <!-- Listado READ -->
    <div class="card">
      <div class="table-toolbar">
        <div class="toolbar-count">
          <i class="fa-solid fa-filter"></i>
          <span>${listaAmenazas.size()} amenazas registradas</span>
        </div>
        <c:set var="critCount" value="0"/>
        <c:set var="highCount" value="0"/>
        <c:set var="medCount" value="0"/>
        <c:forEach var="am" items="${listaAmenazas}">
          <c:if test="${am.nivelRiesgo == 'critical'}"><c:set var="critCount" value="${critCount + 1}"/></c:if>
          <c:if test="${am.nivelRiesgo == 'high'}"><c:set var="highCount" value="${highCount + 1}"/></c:if>
          <c:if test="${am.nivelRiesgo == 'medium'}"><c:set var="medCount" value="${medCount + 1}"/></c:if>
        </c:forEach>
        <div class="toolbar-badges">
          <span class="count-badge critical">${critCount} Crítico</span>
          <span class="count-badge high">${highCount} Alto</span>
          <span class="count-badge medium">${medCount} Medio</span>
        </div>
      </div>

      <div style="overflow-x:auto;">
        <table class="data-table">
          <thead>
            <tr>
              <th>Dispositivo</th>
              <th>Archivo</th>
              <th>Tipo</th>
              <th>Nivel de Riesgo</th>
              <th>Tamaño</th>
              <th>Fecha Detección</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="am" items="${listaAmenazas}">
              <tr>
                <td class="device-cell">
                  <div class="device-name">${am.nombreHost}</div>
                  <div class="device-ip">${am.direccionIp}</div>
                </td>
                <td><span class="file-path">${am.archivo}</span></td>
                <td>${am.tipo}</td>
                <td><span class="badge ${am.nivelRiesgo}">${am.nivelRiesgo}</span></td>
                <td>${am.tamano}</td>
                <td>${am.fechaDeteccion}</td>
                <td>
                  <c:choose>
                    <c:when test="${am.estado == 'Cuarentena'}"><span class="text-cyan">Cuarentena</span></c:when>
                    <c:when test="${am.estado == 'Restaurado'}"><span class="text-green">Restaurado</span></c:when>
                    <c:otherwise><span class="text-muted">${am.estado}</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div class="action-wrap">
                    <c:choose>
                      <c:when test="${am.estado == 'Cuarentena'}">
                        <a class="btn-restaurar" href="Controlador?accion=ActualizarEstado&id=${am.id}&estado=Restaurado">
                          <i class="fa-solid fa-rotate-left"></i> Restaurar
                        </a>
                      </c:when>
                      <c:otherwise>
                        <a class="btn-cuarentena" href="Controlador?accion=ActualizarEstado&id=${am.id}&estado=Cuarentena">
                          <i class="fa-solid fa-box-tissue"></i> Cuarentena
                        </a>
                      </c:otherwise>
                    </c:choose>
                    <a class="btn-eliminar" href="Controlador?accion=Eliminar&id=${am.id}"
                       onclick="return confirm('¿Eliminar definitivamente el registro de &quot;${am.archivo}&quot;? Esta acción no se puede deshacer.')">
                      <i class="fa-solid fa-trash-can"></i> Eliminar
                    </a>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty listaAmenazas}">
              <tr><td colspan="8" style="text-align:center; padding:24px; color:var(--text2);">
                No hay amenazas registradas todavía.
              </td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </main>
</div>

<script>
  setInterval(() => {
    document.getElementById('clock').textContent =
      new Date().toLocaleTimeString('es-CO', { hour:'2-digit', minute:'2-digit', second:'2-digit', hour12:true });
  }, 1000);
</script>
</body>
</html>
