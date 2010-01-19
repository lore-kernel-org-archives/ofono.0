Content-Type: multipart/mixed; boundary="===============9047138867920186209=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Tue, 19 Jan 2010 14:26:51 +0200
Message-ID: <2d5a2c101001190426y71683193qbe4b132393a9d01f@mail.gmail.com>
In-Reply-To: <20100119103338.GA22431@jh-x301>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9047138867920186209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Jan 19, 2010 at 12:33 PM, Johan Hedberg <johan.hedberg@gmail.com>=
 wrote:
> Hi Luiz,
>
> On Tue, Jan 19, 2010, Luiz Augusto von Dentz wrote:
>> Also the problem with this being in the device path is that ofono may
>> not be registered as an agent on connect (both ways) which will cause
>> the connection to drop and the round trips to resolve device path only
>> makes it worse, if this happen to be on adapter path this would not be
>> a problem since we know before hand who to call.
>
> I don't think this is an issue in the case of a per-adapter handsfree
> agent. Typically the agent would be registered upon the creation of the
> device object. Yes, in theory a HFP connection establishment may occur
> before ofono manages to register an agent for the device but the
> connection doesn't need to be dropped because of it. Since it's the
> HF-role device (i.e. us) that sends the initial AT command in HFP SLC
> establishment bluetoothd could just sit quietly waiting until an agent
> registers itself. When an agent finally gets registered bluetoothd would
> (after replying to the registration method call) immediately call the
> NewConnection() method for the agent.

Well it might work, but does it worth? Also I got the impression that
this is not optimal, specially if the we are simulating a combo device
hfp+a2dp this may delay the setup indefinitely until somebody register
an agent , so if I got it right our current code behind Audio.Connect
will not even attempt to connect the sink until headset state
transition from connecting.

Maybe and being paranoid, but I guess this might be troublesome for
mobile hardware where dbus is not that fast.


-- =

Luiz Augusto von Dentz
Engenheiro de Computa=C3=A7=C3=A3o

--===============9047138867920186209==--

