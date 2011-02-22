Content-Type: multipart/mixed; boundary="===============8378856601908019123=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: gatchat looses UR code if received while waiting a response
Date: Tue, 22 Feb 2011 09:44:48 -0600
Message-ID: <4D63D9F0.3070000@gmail.com>
In-Reply-To: <1298378606.8856.82.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8378856601908019123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

>> There's nothing you can do in GAtChat at this point.  Having the
>> unsolicited response handler fire and consume lines before the pending
>> AT command handler won't work either.  If you're not convinced, try
>> handling solicited / unsolicited CREG/CGREG and friends.
> Okay, good to know this, I was not aware. Perhaps I need to reconsider
> the way forward with this issue, we could change the startup sequence of
> different drivers and that way get around this issue. =

>

I suggest putting devinfo on separate multiplexer channel from the one
receiving the STKI notification.  Or we might have to consider extending
gatchat with 'blacklist' prefixes instead of 'whitelist'.

Regards,
-Denis


--===============8378856601908019123==--

