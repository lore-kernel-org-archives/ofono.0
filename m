Content-Type: multipart/mixed; boundary="===============7011350400627535849=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 10:37:34 -0600
Message-ID: <4D25EFCE.3060300@gmail.com>
In-Reply-To: <AANLkTimxkKAjcEdS9hGLECWEaW4o+ygPU3RCikFpcK0i@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7011350400627535849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 01/06/2011 06:02 AM, Sjur Br=C3=A6ndeland wrote:
> Hi Redouane,
> ...
>> +static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
>> +{
>> +       idmap_take(gprs->cid_map, id);
>> +}
>> +
> How do we assure that this CID is not already in use?
> I think the M7400 is going to use CID=3D0 and M700 uses CID=3D1.
> Perhaps we should make sure CID=3D0 is a legal value and reserve CID 0
> and 1 at start up.

You already know how I feel about CID 0, I think you're trying to make
it into something special when it really isn't.

> =

> There is probably other ways of handling this as well, but I think any
> other solution
> would end up with race conditions, as context could be initiated from
> two sources.

The spec is essentially broken in this area.  Barring a complete
redesign of the spec (e.g. making the host stack activate the default
context) reserving a particular range for such default contexts seems
fine to me.

Regards,
-Denis

--===============7011350400627535849==--

