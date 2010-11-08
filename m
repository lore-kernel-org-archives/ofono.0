Content-Type: multipart/mixed; boundary="===============5167853141055391944=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-v2 PATCH 0/3] ofono_sim_ready_notify
Date: Mon, 08 Nov 2010 22:27:42 +0200
Message-ID: <1289248065-3078-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5167853141055391944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is my 3rd stab at the ofono_sim_ready_notify().

I've generalized the role of ofono_sim_ready_notify(): it is expected
after query_passwd_state returns the CME error 14 (SIM busy). It can be
used before or after PIN/PUK checks.

When ofono_sim_ready_notify() is invoked, it checks that the call is
expected and if so, retries the query_passwd_state.

The patches has now been tested with the PIN and PUK codes with mbm and
the new isimodem sim driver by Jukka Saunamaki.

The isimodem driver demonstrates also the case where PIN is disabled but
SIM is not ready yet when oFono tries to initialize the modem. The
isimodem driver tries to read some CPHS information in order to
determine if the modem is ready.

--Pekka


--===============5167853141055391944==--

