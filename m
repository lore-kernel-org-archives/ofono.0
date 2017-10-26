Content-Type: multipart/mixed; boundary="===============1052775970964108860=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecallmanager: Handle last number dialled DBUS call
Date: Thu, 26 Oct 2017 10:25:44 -0500
Message-ID: <18f4afe6-5271-e0e7-ac17-9eddfe9d2dc9@gmail.com>
In-Reply-To: <166b2f17-668d-e010-2865-9149a127035a@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1052775970964108860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>> +=C2=A0=C2=A0=C2=A0 v =3D dial_handle_result(vc, error, NULL, &need_to_=
emit);
>>
>> dial_handle_result is a bit tricky because it handles situations where =

>> ATD returns immediately and then the call is notified via an =

>> unsolicited notification, or ATD returns first.
>>
>> In the case of +BLDN, I believe HFP spec mandates that BLDN always =

>> returns first, which means that much of the logic in =

>> dial_handle_result is not applicable.=C2=A0 It may be better to just =

>> perform the necessary logic directly here.
>>
>> In the current proposal, we will always generate a new call with an =

>> empty phone number which will (hopefully) eventually be updated.=C2=A0 I=
'm =

>> not so sure that this is a great approach, but I can't think of =

>> anything better...
> =

> Not sure I understand your comment completely here. So I don't use =

> dial_handle_result and just setup a voicecall from the callback =

> (voicecall_create)? Or do you mean it is not ideal but acceptable for now?

So in dial_last_callback, instead of calling dial_handle_result, just =

add in the necessary logic from dial_handle_result assuming that the =

BLDN callback is called first.  Commit =

3b951d20f4ae2d6d11b6e7a7485b013aadde050c should make that easier for =

you.  E.g. just call synthethize_outgoing_call inside =

dial_last_callback, reply to the dbus message and emit the signal.

> =

> Regarding your second comment, yes the extra addition of ';' at the end =

> should go. Once I know how to deal with your first comment I'll update =

> the patch and send an extra one for memory dialling which is similar to =

> these.
> =


Sounds good.

Regards,
-Denis

--===============1052775970964108860==--

