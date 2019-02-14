Content-Type: multipart/mixed; boundary="===============6164591526832347795=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [OFONO][Gemalto] Sent SMS status
Date: Thu, 14 Feb 2019 11:07:41 -0600
Message-ID: <10642a14-441f-862a-61f0-22bd6275ea1b@gmail.com>
In-Reply-To: <CAJTQovY9yXoUsTW=_Sox_r7o2r1kvqMu6Ju_jWp85bP6AeCe7Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6164591526832347795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Wajdi,

On 02/14/2019 04:49 AM, wajdi zairi wrote:
> Hi all ,
> =

> =

> We are planning to add a feature to handle sent SMS status . The =

> available OFONO APIs to use seems provided by *org.ofono.Message*=C2=A0bu=
t =

> when i made some tests
> to catch the *PropertyChanged*=C2=A0signal on a sent=C2=A0SMS i notes tha=
t the =

> result is always "sent" (when out from TX) even on a wrong destination =

> number .
> =


Can you elaborate?  If the destination number is still a valid number, =

then this wouldn't be surprising.

> # signal sender=3D:1.12 -> dest=3D(null destination) serial=3D105 =

> path=3D/gemalto_0/message_2F3426EAC5E3EBA365FA626347886C0EC4DC5323; =

> interface=3Dorg.ofond
>  =C2=A0 =C2=A0string "State"
>  =C2=A0 =C2=A0variant=C2=A0 =C2=A0 =C2=A0 =C2=A0string "sent"
> =

> Also the call of *org.ofono.Message.GetProperties*() on given message =

> object path will fail since ofono is removing to object after sending =

> (sms_tx_queue_remove_entry) .

Yes, this is expected behavior and somewhat documented in the =

messagemanager-api.txt.  However, D-Bus API is not meant to be used for =

tracking message history; in fact delivery reports are not even signaled =

via D-Bus.  This is on purpose, since we cannot easily guarantee any =

sort of reliability via any IPC mechanism, and implementing a protocol =

between a history client (using acks or other mechanisms) over D-Bus was =

deemed to be too complicated.  The history plugin is probably what you want.

> =

> So here the "sent" means that the message was treated and out from TX =

> but does not give the real state if it was delivered or not .
> I made a try by adding History driver to our Gemalto drivers and it =

> gives a better result regarding SMS delivery status which meet our =

> requirements.

I'm guessing using status reports?

> =

> To keep our ofono aligned with latest ofono updates, we want to upstream =

> our contributions so i want to get your opinion about a propasal =

> upstream candidate :
> =

> - Add history driver implementation to drivers/gemaltomodems/

Why would SMS history be specific to Gemalto modems?

> - Add signal in plugins/gemalto.c=C2=A0 to notify the different sent mess=
ages =

> status=C2=A0 (indicated on enum*ofono_history_sms_status*=C2=A0)
> - Then the signal can be consumed by any client after=C2=A0sending an SMS=
 .
> =


The reason why we don't have such an API is already covered above. =

Ideally, you want the history plugin to directly update the history in =

your database of choice, or simply call your call/sms history tracking =

service directly.  There's really no reason to broadcast this =

information via a different API.

Regards,
-Denis

--===============6164591526832347795==--

