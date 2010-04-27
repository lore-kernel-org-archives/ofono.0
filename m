Content-Type: multipart/mixed; boundary="===============6333343013029943632=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: DUN client for oFono and BlueZ
Date: Tue, 27 Apr 2010 10:26:27 +0300
Message-ID: <87tyqxqrto.fsf@potku.valot.fi>
In-Reply-To: <20100427063533.GA30819@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6333343013029943632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Gustavo F. Padovan" <gustavo@padovan.org> writes:

> Hi Kalle,

Hi Gustavo,

>> > 4. Agent server on BlueZ. This one is very similar to the HFP Agent se=
rver. At
>> > the end of the DUN agent project I plan to merge the both agent server=
s. SAP
>> > will take advantage of that merge too.
>> >
>> > 5. oFono DUN agent. Implement the agent handling for DUN.
>> =

>> Sorry, I'm not familiar with HFP Agent, but what will this agent
>> actually do on a DUN connection
>
> The agent can request a RFCOMM connection and receive the RFCOMM channel
> via DBus fd-passing. The the DUN plugin can do the handshake.

Ah, that makes perfect sense. Thanks for explaining it.

>> > 6. AT command parser and PPP stack integration with DUN. The biggest t=
ask,
>> > where the core of the project is.
>> >
>> > 7. ConnMan integration. Setup of the NAT and Internet Connections.
>> =

>> Why NAT is needed? I guess only for connection sharing.
>
> No idea yet, I guess Denis told me about the NAT, but that will be the
> last part of the project, so I'm not caring about it now. I have to
> check on my irc logs.

When I was using bt dun on my laptop (just manually running pppd with
debian's pon script) I didn't need nat at all.

-- =

Kalle Valo

--===============6333343013029943632==--

