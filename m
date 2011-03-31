Content-Type: multipart/mixed; boundary="===============0207865419132949914=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 0/9] Emergency Mode
Date: Thu, 31 Mar 2011 09:18:23 -0700
Message-ID: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207865419132949914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch is a proposal for emergency mode. Test has been done
with the phonesim.

Listed down few important cases to give an overview of the state
changes that happen in each case.

Case 1: SIM Present, No PIN required, modem in offline state

	- Modem set to online mode(UI triggered)
		Post online atoms created
	- Dial request received with emergency number
		- Emergency mode activated
		- Dial request sent to modem
	- Emergency call is active
	- Call ended
		Emergency mode deactivated.
	- Modem remains in online mode. Post online
	  atoms are present.

Case 2: SIM Present and PIN required

	- Modem set to online mode(UI triggered)
		Post SIM and Post online atoms not created
	- Dial request received with emergency number
		- Emergency mode activated
		- Dial request sent to modem
	- Emergency call is active
	- Call ended
		Emergency mode deactivated.
	- Modem remains in online mode. Post sim
	  and post online atoms are not present/created.

Case 3: SIM Present and PIN required(Dial request cancelled by user)

	- Modem set to online mode(UI triggered)
		Post SIM and Post online atoms not created
	- Dial request received with emergency number
		- Emergency mode activated
		- Dial request sent to modem
	- Dial request cancelled by user
		Emergency mode deactivated.
	- Modem remains in online mode.
	- User enters the right pin
	- Modem remains in online mode. Post sim
	  and post online atoms are created.

Case 4: SIM Not Present(PIN disabled SIM inserted)

	- Modem set to online mode(UI triggered)
		Post SIM and Post online atoms not created
	- Dial request received with emergency number
		- Emergency mode activated
	- Emergency call is active
	- SIM inserted and SIM ready received(NO PIN required).
		- Post sim and post online atoms are created.
	- Call ended
		Emergency mode deactivated.
	- Modem remains in online mode. Post sim and post
	  online atoms are present.

Case 5: SIM Not Present(PIN enabled SIM inserted)

	- Modem set to online mode(UI triggered)
		Post SIM and Post online atoms not created
	- Dial request received with emergency number
		- Emergency mode activated
	- Emergency call is active
	- SIM Inserted(PIN required).
	- Call ended
		Emergency mode deactivated.
	- Modem remains in online mode. Post sim
	  and post online atoms are not created.

Regards,
Jeevaka

Jeevaka Badrappan (9):
  dbus: Add __ofono_error_emergency_active
  include: add ofono_modem_get_emergency_mode api
  modem: add ofono_modem_get_emergency_mode api
  modem: add Emergency property
  modem: add increment/decrement emergency mode api
  modem: modem state decoupled from rf state
  modem: restrict operations allowed in emergency
  voicecall: generalise emergency call check
  voicecall: add emergency mode handling

 include/modem.h |    2 +
 src/dbus.c      |    7 +++
 src/modem.c     |  135 ++++++++++++++++++++++++++++++++++++++++++++-------=
---
 src/ofono.h     |    4 ++
 src/voicecall.c |   34 ++++++++++----
 5 files changed, 147 insertions(+), 35 deletions(-)


--===============0207865419132949914==--

