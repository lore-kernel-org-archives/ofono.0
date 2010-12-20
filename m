Content-Type: multipart/mixed; boundary="===============6877738314337707265=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v2 4/9] cdma-voicecall: Add CDMA MO Call Support
Date: Mon, 20 Dec 2010 13:47:43 -0800
Message-ID: <4D0FCEFF.2090607@nokia.com>
In-Reply-To: <4D0FC43D.6070503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6877738314337707265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 12/20/2010 01:01 PM, ext Denis Kenzior wrote:

>> +
>> +static const char *voicecall_build_path(struct ofono_cdma_voicecall_man=
ager *vc)
>> +{
>> +     static char path[256];
>> +
>> +     snprintf(path, sizeof(path), "%s/voicecall",
>> +                     __ofono_atom_get_path(vc->atom));
>
> I'm still confused what this is for?  The CDMA voicecall proposal does
> not have leaf objects...
Sorry yes, this is the same oversight as before. I will fix this and =

remove these path references.

Thanks
Dara

--===============6877738314337707265==--

