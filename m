Content-Type: multipart/mixed; boundary="===============2724058618519879701=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: oFono exits on new voicecall with disconnected system bus
Date: Fri, 21 Jan 2011 15:04:47 +0100
Message-ID: <AANLkTi=nAuhq_h_NuweCH=C4yfPy_G0qVycBZHAMNXwQ@mail.gmail.com>
In-Reply-To: <1295611851.3873.306.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2724058618519879701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2011 at 1:10 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:

Hi Marcel,

[...]

>> ofonod[5771]: src/voicecall.c:ofono_voicecall_notify() Did not find a
>> call with id: 1
>> ofonod[5771]: src/voicecall.c:append_voicecall_properties() name =EF=BF=
=BD=EF=BF=BD+@
>> call->name =EF=BF=BD=EF=BF=BD+@
>> ofonod[5771]: System bus has disconnected!
>
> I think that I found the problem. Pushed a patch for it. Please re-test
> if this helps. The Calypso driver was using stack memory for the call
> object.

Yes, it works fine now, going further ;)

Regards

    Niko

--===============2724058618519879701==--

