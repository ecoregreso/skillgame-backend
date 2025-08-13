-- Enable gen_random_uuid if on PostgreSQL with pgcrypto
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE tickets (
  ticket_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_code CHAR(6) NOT NULL,
  pin_hmac CHAR(64) NOT NULL,
  balance_cents BIGINT NOT NULL DEFAULT 0,
  bonus_applied_cents BIGINT NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'active',
  failed_attempts INT NOT NULL DEFAULT 0,
  source TEXT NOT NULL DEFAULT 'cashier',
  created_at timestamptz NOT NULL DEFAULT now(),
  last_used_at timestamptz NULL,
  expires_at timestamptz NULL,
  version BIGINT NOT NULL DEFAULT 1,
  UNIQUE (user_code, pin_hmac)
);

CREATE INDEX idx_tickets_status ON tickets(status);

CREATE TABLE ticket_transactions (
  tx_id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  ticket_id uuid REFERENCES tickets(ticket_id),
  delta_cents bigint NOT NULL,
  balance_after bigint NOT NULL,
  reason text,
  created_at timestamptz DEFAULT now()
);
