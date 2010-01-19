Content-Type: multipart/mixed; boundary="===============0954212745378779677=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Tue, 19 Jan 2010 12:33:38 +0200
Message-ID: <20100119103338.GA22431@jh-x301>
In-Reply-To: <2d5a2c101001190130u3b73737cl2589ba04ec5abd45@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0954212745378779677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, Jan 19, 2010, Luiz Augusto von Dentz wrote:
> Also the problem with this being in the device path is that ofono may
> not be registered as an agent on connect (both ways) which will cause
> the connection to drop and the round trips to resolve device path only
> makes it worse, if this happen to be on adapter path this would not be
> a problem since we know before hand who to call.

I don't think this is an issue in the case of a per-adapter handsfree
agent. Typically the agent would be registered upon the creation of the
device object. Yes, in theory a HFP connection establishment may occur
before ofono manages to register an agent for the device but the
connection doesn't need to be dropped because of it. Since it's the
HF-role device (i.e. us) that sends the initial AT command in HFP SLC
establishment bluetoothd could just sit quietly waiting until an agent
registers itself. When an agent finally gets registered bluetoothd would
(after replying to the registration method call) immediately call the
NewConnection() method for the agent.

Johan

--===============0954212745378779677==--

