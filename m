Content-Type: multipart/mixed; boundary="===============6868778962616952149=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 7/8] netreg: adapt CMER and CIEV for telit
Date: Thu, 16 Aug 2012 08:57:08 +0200
Message-ID: <502C99C4.1060902@hale.at>
In-Reply-To: <5029F463.7000801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6868778962616952149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 14/08/12 08:46, Denis Kenzior wrote:
> Hi Christopher,
>
> On 08/14/2012 09:16 AM, Christopher Vogl wrote:
>> Hi Denis,
>>
>> On 13/08/12 18:25, Denis Kenzior wrote:
>>> Hi Christopher,
>>>
>>> On 08/13/2012 08:23 AM, Christopher Vogl wrote:
>>>> Telit uses a 2 to enable indicator event reporting and
>>>> indicators in a +CIEV URC are identified by strings, not numbers.
>>>
>>> Yikes, can you include a sample AT trace? It sounds like something is
>>> going terribly wrong with CIEVs.
>> I included a debug output from the start of ofono until a valid ppp
>> connection.
>> I attached it at the end as it is quite long and would make this
>> unreadable.
>>
>
> Okay, it looks like the Telit firmware does indeed get this wrong.  So =

> feel free to add a Telit specific CIEV parser.
>
> Also, I'm seeing:
> Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

> src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, toread: 17
> Aug  8 11:36:04 mx31tt01 daemon.err ofonod[496]: EFspn read =

> successfully, but couldn't parse
>
> That looks a bit strange.  Can you rm -rf /var/lib/ofono, rerun oFono =

> and see if that message persists?

I did that but the message still shows up:

...
Aug  8 11:40:00 mx31tt01 daemon.info ofonod[622]: Aux: > =

AT+CRSM=3D176,28486,0,0,17\r
Aug  8 11:40:00 mx31tt01 daemon.info ofonod[622]: Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
Aug  8 11:40:00 mx31tt01 daemon.debug ofonod[622]: =

drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 17
Aug  8 11:40:00 mx31tt01 daemon.debug ofonod[622]: =

src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 17
Aug  8 11:40:00 mx31tt01 daemon.err ofonod[622]: EFspn read =

successfully, but couldn't parse
...

I hardly know anything about SIM FS yet, can you tell me the =

consequences of this please.

Regards,

Christopher

--
Scanned by MailScanner.


--===============6868778962616952149==--

