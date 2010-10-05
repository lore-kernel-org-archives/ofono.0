Content-Type: multipart/mixed; boundary="===============2030996123829476546=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-ready-v0 PATCH 0/3] ofono_sim_ready_notify
Date: Tue, 05 Oct 2010 19:04:18 +0300
Message-ID: <1286294661-24300-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2030996123829476546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is my stab at the ofono_sim_ready_notify().

If SIM is not ready, the ofono_sim_driver indicates that with
query_passwd_state callback returning OFONO_SIM_PASSWORD_INVALID.
    =

After the driver determines that the SIM is ready, it calls
ofono_sim_ready_notify().

The patches has been tested with the mbm and the new isimodem sim driver
by Jukka Saunamaki. The isimodem driver demonstrates also the case where
PIN is disabled and SIM gets eventually ready. =


--Pekka =



--===============2030996123829476546==--

