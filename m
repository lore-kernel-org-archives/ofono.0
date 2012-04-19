Content-Type: multipart/mixed; boundary="===============3815045614838278575=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: Re: [PATCH] voicecall: send CallRemoved for calls when voicecall atom
 is unregistered
Date: Thu, 19 Apr 2012 15:50:40 -0500
Message-ID: <CAB7rCThu4QsYXn+R9JTRSgfcP5xo1XffrBc0WsqFtOxDi4psLg@mail.gmail.com>
In-Reply-To: <4F8EE348.2000602@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3815045614838278575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Apr 18, 2012 at 10:52 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mike,
>
> On 04/18/2012 05:02 PM, Mike Brudevold wrote:
>> From: Michael Brudevold <michael.brudevold@logicpd.com>
>>
>> The CallRemoved signal was not being sent for existing calls when the vo=
icecall
>> atom was unregistered. An example of this is the lack of a CallRemoved s=
ignal
>> when an HFP AG is disconnected due to SLC timeout while a call is active.
>> ---
>> =C2=A0src/voicecall.c | =C2=A0 =C2=A05 ++++-
>> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 104b600..263f1ee 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -2699,8 +2699,11 @@ static void voicecall_unregister(struct ofono_ato=
m *atom)
>> =C2=A0 =C2=A0 =C2=A0 if (vc->dial_req)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dial_request_finish(vc);
>>
>> - =C2=A0 =C2=A0 for (l =3D vc->call_list; l; l =3D l->next)
>> + =C2=A0 =C2=A0 for (l =3D vc->call_list; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 voicecalls_emit_call_removed=
(vc, l->data);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 voicecall_dbus_unregist=
er(vc, l->data);
>> + =C2=A0 =C2=A0 }
>>
>
> In some respect this is on purpose, the application should listen to the
> PropertyChanged on the main Modem object and keep track of Interfaces
> property. =C2=A0e.g. if the VoiceCallManager goes away the application can
> pretty much assume that all calls are gone.
>
> I could use some more convincing that this is really needed...

The only reason I added it is 4 hours of debugging my GUI and ofono to
figure out why the GUI didn't notice the D-Bus path for the voice call
was no longer around.  The documentation for CallRemoved says "Signal
that is sent when a voice call has been released."  This implies it
should be sent every time it is released.  If you update the
documentation to make it clear that this is not always the case, then
it's fine by me.

Mike

>
> Regards,
> -Denis
>
>> =C2=A0 =C2=A0 =C2=A0 g_slist_free(vc->call_list);
>> =C2=A0 =C2=A0 =C2=A0 vc->call_list =3D NULL;
>

--===============3815045614838278575==--

