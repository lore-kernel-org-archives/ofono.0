Content-Type: multipart/mixed; boundary="===============6448954764270012793=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 0/9] Emergency Mode
Date: Tue, 05 Apr 2011 00:00:19 -0500
Message-ID: <4D9AA1E3.9060906@gmail.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6448954764270012793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/31/2011 11:18 AM, Jeevaka Badrappan wrote:
> Hi,
> =

>  Following patch is a proposal for emergency mode. Test has been done
> with the phonesim.
> =

> Listed down few important cases to give an overview of the state
> changes that happen in each case.
> =

> Case 1: SIM Present, No PIN required, modem in offline state
> =

> 	- Modem set to online mode(UI triggered)
> 		Post online atoms created
> 	- Dial request received with emergency number
> 		- Emergency mode activated
> 		- Dial request sent to modem
> 	- Emergency call is active
> 	- Call ended
> 		Emergency mode deactivated.
> 	- Modem remains in online mode. Post online
> 	  atoms are present.
> =

> Case 2: SIM Present and PIN required
> =

> 	- Modem set to online mode(UI triggered)
> 		Post SIM and Post online atoms not created
> 	- Dial request received with emergency number
> 		- Emergency mode activated
> 		- Dial request sent to modem
> 	- Emergency call is active
> 	- Call ended
> 		Emergency mode deactivated.
> 	- Modem remains in online mode. Post sim
> 	  and post online atoms are not present/created.
> =

> Case 3: SIM Present and PIN required(Dial request cancelled by user)
> =

> 	- Modem set to online mode(UI triggered)
> 		Post SIM and Post online atoms not created
> 	- Dial request received with emergency number
> 		- Emergency mode activated
> 		- Dial request sent to modem
> 	- Dial request cancelled by user
> 		Emergency mode deactivated.
> 	- Modem remains in online mode.
> 	- User enters the right pin
> 	- Modem remains in online mode. Post sim
> 	  and post online atoms are created.
> =

> Case 4: SIM Not Present(PIN disabled SIM inserted)
> =

> 	- Modem set to online mode(UI triggered)
> 		Post SIM and Post online atoms not created
> 	- Dial request received with emergency number
> 		- Emergency mode activated
> 	- Emergency call is active
> 	- SIM inserted and SIM ready received(NO PIN required).
> 		- Post sim and post online atoms are created.
> 	- Call ended
> 		Emergency mode deactivated.
> 	- Modem remains in online mode. Post sim and post
> 	  online atoms are present.
> =

> Case 5: SIM Not Present(PIN enabled SIM inserted)
> =

> 	- Modem set to online mode(UI triggered)
> 		Post SIM and Post online atoms not created
> 	- Dial request received with emergency number
> 		- Emergency mode activated
> 	- Emergency call is active
> 	- SIM Inserted(PIN required).
> 	- Call ended
> 		Emergency mode deactivated.
> 	- Modem remains in online mode. Post sim
> 	  and post online atoms are not created.
> =


All 9 patches have been applied, in a slightly different order.  Thanks
for that!

I made some slight refactorings and additions afterward, and went ahead
and marked this task as done.  Can you take a look and see if you concur
with my changes?

Regards,
-Denis

--===============6448954764270012793==--

