-- ================================================================
-- Migration 014: Teamleiter dürfen Werber-Zuordnungen bearbeiten
-- ================================================================
-- Erlaubt Teamleitern das Aktualisieren von campaign_area_id
-- für Werber in ihren eigenen Kampagnen-Zuweisungen
-- ================================================================

-- Policy für Teamleiter: Können ihre eigenen Team-Zuordnungen bearbeiten
CREATE POLICY "Teamleiter can update their team assignments"
  ON public.campaign_assignment_werber
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1
      FROM public.campaign_assignments ca
      JOIN public.users u ON u.id = auth.uid()
      WHERE ca.id = campaign_assignment_werber.assignment_id
        AND ca.teamchef_id = auth.uid()
        AND u.role IN ('teamleiter', 'admin')
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.campaign_assignments ca
      JOIN public.users u ON u.id = auth.uid()
      WHERE ca.id = campaign_assignment_werber.assignment_id
        AND ca.teamchef_id = auth.uid()
        AND u.role IN ('teamleiter', 'admin')
    )
  );

-- ================================================================
-- FERTIG! Teamleiter können jetzt Werbegebiete zuordnen.
-- ================================================================
