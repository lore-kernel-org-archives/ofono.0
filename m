Content-Type: multipart/mixed; boundary="===============3834145948022432960=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 6/6] stk: Introduce BIP command handlers
Date: Tue, 19 Apr 2011 01:56:21 +0200
Message-ID: <BANLkTimMZ7_4t_AH4DJKzCm77wcc_g+UrQ@mail.gmail.com>
In-Reply-To: <4DA5B515.2070909@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3834145948022432960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 13 April 2011 16:37, Denis Kenzior <denkenz@gmail.com> wrote:
...
>> Indeed, in practice, this modification is coming from BIP handler
>> implementation, but this is uncorrelated from BIP.
>> Here, the idea of this modification is to update the flag only once the
>> Terminal response has been sent.
>> My understanding of this flag is to allow to send a Terminal response
>> "Proactive UICC session terminated by the user" once the stk agent exits
>> (user quits).
>
> Yep, that is correct.
>
>>
>> But this case still subsists even after the user confirms to setup a
>> voice call or to setup a BIP channel. For such cases, we need to
>> establish the link before returning the terminal response, which can
>> take a while.
>>
>> Actually, in the callback 'confirm_call_cb', the flag
>> stk->respond_on_exit is set back to FALSE whereas the Terminal response
>> is not already sent. Fact is that the user may exit the stk agent before
>> the call is connected. In this case, no terminal response is sent,
>> leading to a potential mismatch regarding the expected answer from SIM.

I can't see the mismatch happening, ofono always sends the response
sooner or later.

>
> This is a good point. =C2=A0Andrew's idea was that once the Dial has been
> sent, the EndSesion can be triggered by hanging up the call and tracking
> the session agent is no longer needed (as Setup Call is usually the end
> of a session anyway)
>
> I don't mind triggering EndSession via the Agent exiting as well in this
> case.

Ah, I see that how that might work.  Although the spec only mentions
the "session terminated by the user" response in the "confirmation
phase" and not in the "setup phase".

Best regards

--===============3834145948022432960==--

