Content-Type: multipart/mixed; boundary="===============2806220459386430573=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: STK DisplayText changes proposal
Date: Wed, 24 Nov 2010 00:29:40 +0100
Message-ID: <AANLkTikaLZOFj2to93n9sMGYXtO29StLogb3j7PDgw=S@mail.gmail.com>
In-Reply-To: <4CEBF500.1000607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2806220459386430573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 23 November 2010 18:08, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/23/2010 10:55 AM, Andrzej Zaborowski wrote:
>> As for the clear after delay flag, there's a check for it in
>> display_text_cb (line 1248). =C2=A0As far as I can make out the only
>> difference is the response sent to the SIM.
>
> So it has been a long time since those discussions, but it does seem to
> me that using a higher timeout in the case of 'wait_for_user' flag seems
> like a good idea. =C2=A0Do you remember why we left this out?

No, I don't, I'll send a patch to use the normal timeout instead of
short timeout when clearing after user action is requested.  As for
the proposal to add a parameter clear_after_delay and the ScreenBusy
response I'm fine with both of them (as I don't think the saving from
hiding these details is worth it) but I leave it up to you and
Guillaume.  It seems that a user action always clears the message but
it may be good to display a "confirm" button anyway.  The ScreenBusy
response is also possible for other proactive commands so for
consistency would need to be added there too.

Best regards,
Andrew

--===============2806220459386430573==--

