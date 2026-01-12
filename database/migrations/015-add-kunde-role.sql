-- ================================================================
-- Migration 015: Kunde-Rolle hinzufügen
-- ================================================================
-- Erweitert die erlaubten Rollen um 'kunde'
-- ================================================================

-- Alten Constraint entfernen
ALTER TABLE users DROP CONSTRAINT IF EXISTS users_role_check;

-- Neuen Constraint mit allen Rollen hinzufügen
ALTER TABLE users ADD CONSTRAINT users_role_check
  CHECK (role IN ('werber', 'teamleiter', 'admin', 'quality', 'kunde'));

-- ================================================================
-- FERTIG! Jetzt können User die Rolle 'kunde' bekommen.
-- ================================================================
