Content-Type: multipart/mixed; boundary="===============2818984122695493433=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] gobi: enable message waiting atom
Date: Tue, 12 Sep 2017 12:47:00 -0500
Message-ID: <1584ec27-a8c2-95b9-8795-508de84ef9f7@gmail.com>
In-Reply-To: <20170912055650.CF06460F2C@rivendell.scintill.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2818984122695493433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

On 09/10/2017 01:16 AM, Joey Hewitt wrote:
> ---
> =

> On 09/10/2017 10:59 AM, Denis Kenzior wrote:
>> Does DMS provide support to twiddle the EFmwis/EFmwi/EFmbdn by some
>> other means?  From what I remember it doesn't, but may be I'm not
>> remembering correctly.
>>
>> If not, then we shouldn't enable message-waiting in that case.
> =

> I'm not an expert, but from looking Gobi API, maybe the PBM service can
> update MBDN (eQMIPBMPhonebookTypes_MailBoxDialingNumber) and WMS could
> update MWI (WMSSetWaitingMessage). I don't see docs or examples of how
> they work though, and I haven't tried. I also don't know if it makes
> sense for oFono's target devices that don't have/use the UIM service.

In theory we could intercept the writes to those files in sim-legacy and =

based on the file-id invoke the right PBM/WMS command.  But that seems =

like too much trouble.

> =

> Since the legacy SIM atom doesn't have that now, I've made the feature
> check for the UIM service, as well as not "ForceSimLegacy" flag.

Yes, good catch!

Patch has now been applied, thanks.

Regards,
-Denis

--===============2818984122695493433==--

