Content-Type: multipart/mixed; boundary="===============8613995871630168944=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 10:47:59 -0600
Message-ID: <4D25F23F.3060208@gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9C123FBC@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8613995871630168944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

On 01/06/2011 08:59 AM, Soum, RedouaneX wrote:
> Hi Sjur,
> =

> =

>>> +static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
>>> +{
>>> +       idmap_take(gprs->cid_map, id);
>>> +}
>>> +
>> How do we assure that this CID is not already in use?
>> I think the M7400 is going to use CID=3D0 and M700 uses CID=3D1.
>> Perhaps we should make sure CID=3D0 is a legal value and reserve CID 0
>> and 1 at start up.
> =

> From my understanding the ID in the core is an internal ID for oFono core=
, even if today we usually have a mapping 1 to 1 between oFono core ID and =
modems CID.
> Denis, Marcel could you confirm ?
> =


Actually the intent was and still is to map it 1:1 to the modem cid to
make life easier for the drivers.  Since we follow 27.007 this makes
sense.  The modem driver can still do its own internal id mapping /
management, e.g. isi drivers do this AFAIK.  For AT modems I'd like to
avoid doing so...

oFono can be told the range of cids to use.  There's nothing precluding
the modem from giving oFono cids that are not in this range when a
context is auto-activated.

However, this gets into a real gray area whether you can have multiple
(network|auto)-activated contexts and whether the cid picked for all of
them is guaranteed to be outside this range.

Regards,
-Denis

--===============8613995871630168944==--

