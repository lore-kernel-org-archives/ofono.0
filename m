Content-Type: multipart/mixed; boundary="===============2062948078179488575=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Wed, 12 Jan 2011 10:46:46 -0600
Message-ID: <4D2DDAF6.5050600@gmail.com>
In-Reply-To: <1294818062.24900.21.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2062948078179488575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 01/12/2011 01:41 AM, Jukka Saunamaki wrote:
> Hello
> =

> On Tue, 2011-01-11 at 22:48 -0800, ext Marcel Holtmann wrote:
>>> +	if (sim !=3D NULL) {
>>> +		ofono_sim_read(sim, SIM_EFSPN_FILEID,
>>> +				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>>> +				sim_spn_read_cb, req);
>>> +		return;
>>> +	}
>>
>> Should this not be provided somehow by the SIM atom?
>>
>> Denis, any idea why we are not keeping this information available?
>>
> =

> I would guess there was no need for it, since netreg was the only user
> for EFSPN data.
> =

> I though of patching the SIM atom to read this during some phase of SIM
> initialization, but was not sure exactly when, and what kind of
> interface (syncronous, asyncronous?) to provide.
> =


You're correct that netreg is the only consumer.  There was no need for
anyone else to see this information.  However, this begs the question,
why do you need the SPN data?

Regards,
-Denis

--===============2062948078179488575==--

