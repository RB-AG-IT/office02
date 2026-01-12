-- ================================================================
-- Migration 013: Role Constraint aktualisieren
-- ================================================================
-- Erweitert die erlaubten Rollen um 'teamleiter', 'admin', 'quality'
-- ================================================================

-- Alten Constraint entfernen
ALTER TABLE users DROP CONSTRAINT IF EXISTS users_role_check;

-- Neuen Constraint mit allen Rollen hinzufügen
ALTER TABLE users ADD CONSTRAINT users_role_check
  CHECK (role IN ('werber', 'teamleiter', 'admin', 'quality'));

-- ================================================================
-- FERTIG! Jetzt können User die Rolle 'teamleiter' bekommen.
-- ================================================================
