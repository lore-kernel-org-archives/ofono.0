Content-Type: multipart/mixed; boundary="===============4505083837715713198=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] sim: Read EFsst
Date: Thu, 26 Aug 2010 17:12:49 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A516CB5@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C755013.3040603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4505083837715713198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>>  out:
>>  	sim_retrieve_imsi(sim);
>> +	return;
>> +
>> +error:
>> +	ofono_sim_read(sim, SIM_EFSST_FILEID,
>> +			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>> +			sim_efsst_read_cb, sim);
>>  }
>
>That is really not how it works.  If the file ID is the same then you
>need some other information to determine whether this is a phase 3 or a
>phase 2 SIM.  Look at how EFecc reading in voicecall.c is done.  In
>other words, this function needs to make an intelligent decision whether
>this is EFsst or EFust.
>
>In your case the only heuristic we have is EFphase, which is mandatory
>for all Phase 2 SIMs (and absent in all Phase 3 SIMs).





--===============4505083837715713198==--

