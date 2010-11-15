Content-Type: multipart/mixed; boundary="===============8045282303553442930=="
MIME-Version: 1.0
From: Predon, Frederic <frederic.predon@intel.com>
Subject: RE: [PATCH 0/4] Emergency Calls (3rd round)
Date: Mon, 15 Nov 2010 10:45:53 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934C9E0A90@irsmsx501.ger.corp.intel.com>
In-Reply-To: <cover.1289664478.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8045282303553442930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> Here is a new proposal for emergency calls handling.
> =

> Steps in handling emergency calls:
> - subscribe to modem online notifications (add modem online watcher)
> - an emergency call detected (phone number is emergency number)
> - increment emergency mode
>   - advertise "EmergencyMode" property change on D-Bus (first call)
>   - set modem online if it's in offline mode (minimal setup)
>     - adevertise "Online" property change on D-Bus
> - if modem is not online postpone making the call, otherwise make
>   the emergency call
> - when modem online notification comes and there is postponed call
> request
>   make the emergency call
> - when an emergency call ends decrement emergency mode
>   - set modem offline if it was set online due to the emergency call
> (last call)
>     - advertise "Online" property change on D-Bus
>   - advertise "EmergencyMode" property change on D-Bus (last call)

Do you handle the case of making an emergency call when there is no SIM car=
d?

Fred
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8045282303553442930==--

