Content-Type: multipart/mixed; boundary="===============9082215984539688126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] coex: Adding documetation for coex interface
Date: Tue, 27 Nov 2018 09:04:31 -0600
Message-ID: <97fd3f71-6920-7100-99ea-206435fcd902@gmail.com>
In-Reply-To: <20181127090129.GB20504@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9082215984539688126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 11/27/2018 03:01 AM, Pavel Machek wrote:
> Hi!
> =

>> +LTE Coexistence hierarchy
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Service		org.ofono
>> +Interface	org.ofono.IntelLTECoex*
>> +Object path	[variable prefix]/{modem0,modem1,...}
> =

> The interface should be generic, not Intel-specific in the end, right?

This would be ideal, however we have no idea how this type of =

functionality works on modems from other manufacturers.  So until we can =

determine that a generic API is possible, we're keeping this one as a =

vendor specific API.

Regards,
-Denis

--===============9082215984539688126==--

