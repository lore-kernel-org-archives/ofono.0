Content-Type: multipart/mixed; boundary="===============7356363915109287765=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: Discussion on CTM enhancement
Date: Tue, 11 Jan 2011 22:30:44 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4140D3D68@008-AM1MPN1-002.mgdnok.nokia.com>
In-Reply-To: <1294178578.5852.115.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7356363915109287765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 05 Jan 2011, Marcel Holtmann wrote:
>> our case, we are receiving unsolicited AT commands "CTM CALL" when the
>> remote party has accepted the call as a TTY enabled device and "NO CTM
>> CALL" when the remote has accepted the call but his device is not TTY
>> enabled.
> =

> I think we need a property inside the voice call that indicates that
> this is a TTY call. You have played with TTY hardware which I have not.

yes, but we need to be clear on semantics. So specifically, =

I'm assuming "TTY call" here would mean that MS has indicated CTM =

support in its bearer capability flags (24.008). This is sent when =

establishing calls, and is sent both for MO&MT calls. This is
common to all modems supporting CTM.

> So we might need to figure what the UI requirement for TTY really is.
> This is still pretty much unclear to me how this all needs to be
> indicated to the actual impaired user. Any experts here?

Not an expert either, but as nobody else seems to be commenting, =

I'll give it a go. ;) For really high-level explanation, see:
http://www.nokiaaccessibility.com/textphones.html

So the configuration is fairly static. User needs to select =

TTY mode in device settings _and_ connect the textphone. Only
if these conditions are met, should the CTM flag be set for
established calls.

So basicly just having org.ofono.TextTelephony.Enabled (controlling
whether CTM is enabled or not for any created calls) is enough
for a basic implementation.

If I've understood correctly, ifxmodem allows additionally
to enable CTM when a) you get a MT call with CTM flag
set, and b) org.ofono.TextTelephony.Enabled=3D=3DFALSE is before =

the call. So if this is exposed as a voicecall property, UI can =

notify the user to connect the textphone (in case TTY is enabled
in device settings). But I'm guessing a bit here, so Fred and =

others, please correct any mistakes in this.

PS This is not to be confused what actually happens on the traffic
   channel. There's also inband negotiation specified for CTM =

   (in 26.226), but AFAIK nobody is proposing to expose any =

   of this via oFono (and if it was, this would be highly modem
   specific as the CTM codec is not necessarily even implemented
   in the modem).


--===============7356363915109287765==--

