Content-Type: multipart/mixed; boundary="===============7855593169004355965=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] netreg: adapt CMER and CIEV for telit
Date: Tue, 14 Aug 2012 01:46:59 -0500
Message-ID: <5029F463.7000801@gmail.com>
In-Reply-To: <502A5DBE.1010404@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7855593169004355965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/14/2012 09:16 AM, Christopher Vogl wrote:
> Hi Denis,
>
> On 13/08/12 18:25, Denis Kenzior wrote:
>> Hi Christopher,
>>
>> On 08/13/2012 08:23 AM, Christopher Vogl wrote:
>>> Telit uses a 2 to enable indicator event reporting and
>>> indicators in a +CIEV URC are identified by strings, not numbers.
>>
>> Yikes, can you include a sample AT trace? It sounds like something is
>> going terribly wrong with CIEVs.
> I included a debug output from the start of ofono until a valid ppp
> connection.
> I attached it at the end as it is quite long and would make this
> unreadable.
>

Okay, it looks like the Telit firmware does indeed get this wrong.  So =

feel free to add a Telit specific CIEV parser.

Also, I'm seeing:
Aug  8 11:36:04 mx31tt01 daemon.debug ofonod[496]: =

src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, toread: 17
Aug  8 11:36:04 mx31tt01 daemon.err ofonod[496]: EFspn read =

successfully, but couldn't parse

That looks a bit strange.  Can you rm -rf /var/lib/ofono, rerun oFono =

and see if that message persists?

Regards,
-Denis

--===============7855593169004355965==--

