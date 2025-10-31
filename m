Received: from mail.expatria.ca (mail.expatria.ca [144.217.207.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759BC51022
	for <ofono@lists.linux.dev>; Sat,  1 Nov 2025 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.207.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028021; cv=none; b=d5zbpRnnK6yST4RzLj1vJHXRHwb72gJdEi0vjDa/om4KN7mAaYRD2pgh33np9R4PNaOzip8iytOz7l/kRZe8OM65eeMOgLRaXZ1DHptPrm4iSu/fm4KlRahzeSTzvCH1RxJ+mEy6Q34LXdOWk8+nSefPWE/wNfZcdBz6GcYQYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028021; c=relaxed/simple;
	bh=X7NoJnDnWLTfsDgwpjA4XRQFOv0DlRVKVTz/j+XJbno=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=aGc5OX7Zk2cGRuuGm45VGwaoTQATsN9B8tSu/CEoM0BLiKnW8jv7V/CFbyOiCuFhs/UK/ML/JinlWNOg0w8J/QGprn5/xBdQsyreIKkovi9ldnjl2MnG5wKxiqaPLggRV0JS5/bsBEHUdITQ9eRiQ1jHj17ANrZF1GOwKv9MOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=expatria.ca; spf=pass smtp.mailfrom=expatria.ca; dkim=pass (2048-bit key) header.d=expatria.ca header.i=@expatria.ca header.b=MgSghzvt; arc=none smtp.client-ip=144.217.207.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=expatria.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=expatria.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=expatria.ca header.i=@expatria.ca header.b="MgSghzvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=expatria.ca;
	s=default; t=1761939245;
	bh=X7NoJnDnWLTfsDgwpjA4XRQFOv0DlRVKVTz/j+XJbno=;
	h=Date:To:From:Subject:From;
	b=MgSghzvtFHbitiEUHXdRoR6NLeCyDmYJL8zbBg1BOo4iz0LpOZE8E8zjqYoHrs7Vm
	 C99K+z8z297kAy/GJT2neTkJ4p7VIPaBgmPVoWL5GqSfYLZicJxTpTkBPOMkiNC+Mb
	 xhLPgkRhkOWC+2H1IN8NpTwWEvRxQBS4vTTqa8QPoC/neq7kXghcsB/rrUutIH+w2D
	 txf9Q9r0Ogv6FcWcmbh5CQVCQ8o9MuBYbT/Es2UhaTx+tyPUtvrG/scH0OZV9Q4A+5
	 xBcIkzAFOSB1UYjUKZiSk4AV02EKKSRExQr814KsmrON+AxfR2RVMADSAka3QIIAZT
	 9T/xlihrP6BhA==
Received: from [10.89.51.52] (d154-20-248-80.bchsia.telus.net [154.20.248.80])
	by mail.expatria.ca (Postfix) with ESMTPSA id AA8BA18655
	for <ofono@lists.linux.dev>; Fri, 31 Oct 2025 19:34:05 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------7AQl17BUJ69ilLGt98UChPni"
Message-ID: <10f1a2d8-375c-44cb-bdd8-79040de34787@expatria.ca>
Date: Fri, 31 Oct 2025 12:34:04 -0700
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ofono@lists.linux.dev
From: Morgan Hughes <morgan@expatria.ca>
Subject: Patch for crash parsing malformed MBIM packets

This is a multi-part message in MIME format.
--------------7AQl17BUJ69ilLGt98UChPni
Content-Type: multipart/alternative;
 boundary="------------LLPBuDhDUmpWUid0S2oFwoYs"

--------------LLPBuDhDUmpWUid0S2oFwoYs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi oFono devs,

I have a client using oFono in the stack for an IoT gateway with a Cinterion PLS62-W 
modem. On a small number of units, at random, this modem sends a specific URC as an MBIM 
packet.  oFono parses the ASCII bytes as an MBIM header, leading to a wild pointer and a 
segfault:
    MBIM:n_iov: 3, 60
    MBIM:> 03 00 00 00 3c 00 00 00 0b 00 00 00 01 00 00 00 ....<...........
    MBIM:  00 00 00 00 53 3f be eb 14 fe 44 67 9f 90 33 a2 ....S?....Dg..3.
    MBIM:  23 e5 6c 3f 02 00 00 00 00 00 00 00 0c 00 00 00 #.l?............
    MBIM:  00 00 00 00 00 00 00 00 00 00 00 00 ............
    MBIM:< 2b 43 4d 47 4c 3a 20 31 2c 31 2c 2c +CMGL: 1,1,,
    MBIM:hdr->len: 824195660, header_size: 12, header_offset: 12
    MBIM:segment_bytes_remaining: 824195648
    MBIM:hdr->len: 824195660, header_size: 12, header_offset: 12
    MBIM:segment_bytes_remaining: 824195309
    MBIM:hdr->len: 824195660, header_size: 12, header_offset: 12
    MBIM:segment_bytes_remaining: 824195058

I added a safety check and after a few days of testing it seems to have solved the 
problem. I've attached a patch against the current master in hopes it'll be useful.

Thanks,

Morgan Hughes

--------------LLPBuDhDUmpWUid0S2oFwoYs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi oFono devs,</p>
    <p>I have a client using oFono in the stack for an IoT gateway with
      a Cinterion PLS62-W modem. On a small number of units, at random,
      this modem sends a specific URC as an MBIM packet.  oFono parses
      the ASCII bytes as an MBIM header, leading to a wild pointer and a
      segfault:<br>
      <font face="monospace">   MBIM:n_iov: 3, 60<br>
           MBIM:&gt; 03 00 00 00 3c 00 00 00 0b 00 00 00 01 00 00 00 
        ....&lt;...........<br>
           MBIM:  00 00 00 00 53 3f be eb 14 fe 44 67 9f 90 33 a2 
        ....S?....Dg..3.<br>
           MBIM:  23 e5 6c 3f 02 00 00 00 00 00 00 00 0c 00 00 00 
        #.l?............<br>
           MBIM:  00 00 00 00 00 00 00 00 00 00 00 00             
        ............<br>
           MBIM:&lt; 2b 43 4d 47 4c 3a 20 31 2c 31 2c 2c             
        +CMGL: 1,1,,<br>
           MBIM:hdr-&gt;len: 824195660, header_size: 12, header_offset:
        12<br>
           MBIM:segment_bytes_remaining: 824195648<br>
           MBIM:hdr-&gt;len: 824195660, header_size: 12, header_offset:
        12<br>
           MBIM:segment_bytes_remaining: 824195309<br>
           MBIM:hdr-&gt;len: 824195660, header_size: 12, header_offset:
        12<br>
           MBIM:segment_bytes_remaining: 824195058</font></p>
    <p>I added a safety check and after a few days of testing it seems
      to have solved the problem. I've attached a patch against the
      current master in hopes it'll be useful.</p>
    <p>Thanks,</p>
    <p>Morgan Hughes</p>
  </body>
</html>

--------------LLPBuDhDUmpWUid0S2oFwoYs--
--------------7AQl17BUJ69ilLGt98UChPni
Content-Type: text/x-patch; charset=UTF-8; name="mbim-header-validate.patch"
Content-Disposition: attachment; filename="mbim-header-validate.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWJpbW1vZGVtL21iaW0uYyBiL2RyaXZlcnMvbWJpbW1v
ZGVtL21iaW0uYwppbmRleCBjNDA1NzYxZC4uNDMyMmY1YWQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbWJpbW1vZGVtL21iaW0uYworKysgYi9kcml2ZXJzL21iaW1tb2RlbS9tYmltLmMKQEAg
LTE4LDYgKzE4LDcgQEAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogCiAjaW5jbHVkZSA8
ZWxsL2VsbC5oPgorI2luY2x1ZGUgPGVsbC91c2VmdWwuaD4KIAogI2luY2x1ZGUgIm1iaW0u
aCIKICNpbmNsdWRlICJtYmltLW1lc3NhZ2UuaCIKQEAgLTYxMyw2ICs2MTQsMTUgQEAgc3Rh
dGljIGJvb2wgY29tbWFuZF9yZWFkX2hhbmRsZXIoc3RydWN0IGxfaW8gKmlvLCB2b2lkICp1
c2VyX2RhdGEpCiAJaGRyID0gKHN0cnVjdCBtYmltX21lc3NhZ2VfaGVhZGVyICopIGRldmlj
ZS0+aGVhZGVyOwogCXR5cGUgPSBMX0xFMzJfVE9fQ1BVKGhkci0+dHlwZSk7CiAKKwlpZiAo
dW5saWtlbHkoaGRyLT5sZW4gPiBNQVhfQ09OVFJPTF9UUkFOU0ZFUikpIHsKKwkJY2hhciAq
aGV4ID0gbF91dGlsX2hleHN0cmluZyhkZXZpY2UtPmhlYWRlciwKKwkJCQkJCXNpemVvZihz
dHJ1Y3QgbWJpbV9tZXNzYWdlX2hlYWRlcikpOworCQlsX3dhcm4oIk1CSU06IHNraXAgaW1w
bGF1c2libGUgaGRyICVzOiBsZW4gMHgleCB0eXBlIDB4JXgiLCBoZXgsCisJCQlMX0xFMzJf
VE9fQ1BVKGhkci0+bGVuKSwgTF9MRTMyX1RPX0NQVShoZHItPnR5cGUpKTsKKwkJbF9mcmVl
KGhleCk7CisJCXJldHVybiBmYWxzZTsKKwl9CisKIAlpZiAoZGV2aWNlLT5zZWdtZW50X2J5
dGVzX3JlbWFpbmluZyA9PSAwKQogCQlkZXZpY2UtPnNlZ21lbnRfYnl0ZXNfcmVtYWluaW5n
ID0KIAkJCQkJTF9MRTMyX1RPX0NQVShoZHItPmxlbikgLQo=

--------------7AQl17BUJ69ilLGt98UChPni--
