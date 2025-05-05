Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75B1F540F
	for <ofono@lists.linux.dev>; Mon,  5 May 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459975; cv=none; b=mj2vu+GPfU1fMLILG0zgn0bnZVgpgRHikx5AXlHP/9C9Lw55XMpNbOfgUMglnetNs02HDq/864PCp+73pLL8Fg+gNy+q40oURBJLFIhR3TB6j+y5Yz9hcXHPyA38AOVYIEvSd7UXd87dfGXs/gSYuYePL1sE3zq9FznOlvZhzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459975; c=relaxed/simple;
	bh=fHuOzZAIjrZIMVA5fOwFpM8rFxGDrkaLt7Rzj5ViRUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CU9E4ibWlwHYdNkkyMm2yMCb4c+FWiax0GRlUbfkHINTakbfx7RVh61QSfIl0Ae/oAHh2LdCO+ztqybWP3eRu0rpim9lSpZqfSWPuT9WMmR7Bm4Pa8eo1rzY6ykKWV9HBkgFt1P6i2vEjz81kw4hPg1dswoQnXBbPGXFDn4tnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btgQXWPZ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btgQXWPZ"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60658e1fedfso2213106eaf.2
        for <ofono@lists.linux.dev>; Mon, 05 May 2025 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746459972; x=1747064772; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBgweLDv/LwY3mb90fVeNt7D5/12BAL9kxz6+XF7Bao=;
        b=btgQXWPZV2bjEta+OXICMNvt8xW1mje51OXXLXvyFEONJM5L9uf5Pq3judl6chfQtF
         l7If+65qq1mDRiWyy9UWWACx97pk9eMXEPw5bnU9Ci2nTlKosTOC77r2cVuWLMA8kUEV
         kWOfgjF3GjrS83ICZG6G4dTjNSXXy8FeH0ocOEzo1IoTWEdYFzmC7FbzDBIMN7GSlVH7
         gwTMBq0Fr3ooq9eVT9I5rE4aW0zdGWPAVaWYLpgXDdVG7HXWgmGEVskSnbkSWn3SDz2f
         Lowb32OhoJek8H9OMOxMadahcDDBglGtXufVHrpkLxoUAT9RUm1PlEDQnfxDOP4CpVXE
         VAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746459972; x=1747064772;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBgweLDv/LwY3mb90fVeNt7D5/12BAL9kxz6+XF7Bao=;
        b=liuDuLaT28wQZmszyqlOxZ2jMGY0jNRQM+M2i+fNs/5c4gYyiHAYONiY3icMDptTID
         4t3Snh4RsJ+L0n7TvGTXuEXIykbz/KcMunv21uyhuQaNaOq93FlW8l9SpPCk73cEeKu0
         ndA0hip52ppPlGhp4JlYebkzRdOd30C2ED2gOKkjjQKBx4YHfKKnfXPxFGsncSg99VQM
         4iplPh5uhii+zYR9O1q8JsfARrulc1G+mp6FsO2WbKhFS8ShpN35xvb36XNqYMOELB0i
         5LnPJPHuAlYYtyT66Ls8pMKzLGCpAmnaxLK8I8XGw7lZBbVlCUFZOpyqOepOeUjyRxbu
         jxdg==
X-Forwarded-Encrypted: i=1; AJvYcCWMouMkqef6XVSsaj+jzyXDys5ugnx3VPfDEPsjx6XIlhqUblILHSmG5kXH6L15Yw+pf4c5yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo4x1E/Le44cSLjAhKNkSefJZc75Cwvat/Aw6GRbBDm0dVh2wl
	JkYNErmScO0od7NVmLWXirDlpJQWjmlw+JXOEnrH3WiOxIPUb+e7
X-Gm-Gg: ASbGnctYHP7y07Ec5bZVk9S602WDrSNWnMrjQX0bkLV0HcxaiqGLo703TAYRB80UUOq
	PzTioPexaopdPEDUOafpQu/kFB3EoybfUc4VKctNW95FRGlSH9A8+ykLyXxRcNahHa5Mx0xPnNo
	hJ6I02hTUlTYNMlYih/PkTmQ8mdTVM3bRZrpBEowx0Y50E0E+NXW6dF66jg8Z19/5X7kAoxoEK9
	FIXUkWHS6/1glSJ5jZqrJYluEaoTGM1LPU+eTkw8U/n7OJY8oLGe18xmNC+vRs7P8brByyTRkmD
	IPiWElVs36CKwrGSR/Q9IamYnH8G6Ur2grx1z/clbnKzOkQK1OVwUH+yvIkFmpIui5DwVONbJUE
	n0HTAig==
X-Google-Smtp-Source: AGHT+IGTif05nvLHdJKRn1nE3HeLiaL8jkZ5jpPtukqVIEnfkVO3HR1bRA+ZWHfAhGTsbiBcD17+KA==
X-Received: by 2002:a05:6870:e9a2:b0:29e:2da3:3f7b with SMTP id 586e51a60fabf-2dab2f40ca3mr7819067fac.7.1746459972069;
        Mon, 05 May 2025 08:46:12 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2daa0a438e8sm2031517fac.0.2025.05.05.08.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 08:46:11 -0700 (PDT)
Message-ID: <b227dde1-b41e-46fa-98ee-24c4afef9ddf@gmail.com>
Date: Mon, 5 May 2025 10:46:10 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] plugins/udevng: Add support for PCIe MBIM modems *
 Parses through the sysfs tree and detects MBIM control nodes, net and AT
 nodes
To: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>,
 ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-2-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20250504191931.7078-2-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 5/4/25 2:19 PM, Muhammad Asif wrote:
> ---
>   plugins/udevng.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 

Some general comments:

oFono still prefers that lines are limited to 80 characters, so please 
restructure accordingly.  Also, checkpatch still flags some other issues:

0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:8: WARNING: 
Missing commit description - Add an appropriate one
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:70: WARNING: 
line length of 105 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:72: WARNING: Too 
many leading tabs - consider code refactoring
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:74: WARNING: Too 
many leading tabs - consider code refactoring

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index b8df66de..09c916db 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1176,7 +1176,13 @@ static gboolean setup_mbim(struct modem_info *modem)
>   {
>   	const char *ctl = NULL, *net = NULL, *atcmd = NULL;
>   	GSList *list;
> +	const char *sub_subsystem = NULL, *type = NULL;
> +	char path[512], wwan_path[1024], sub_path[2048];
>   	char descriptors[PATH_MAX];
> +	struct udev *new_udev;
> +	struct udev_device *wwan_device, *sub_device;
> +	struct dirent *dir = NULL, *subdir = NULL;
> +	DIR *d = NULL, *sd = NULL;
>   
>   	DBG("%s [%s:%s]", modem->syspath, modem->vendor, modem->model);
>   

I see that you added "mbim" to a list of pci drivers in patch 4.  This patch and 
patch 4 should be combined into a single patch.  Can you provide a log from 
'ofonod -nd'?  Especially after patch 4, oFono should be detecting all nodes 
related to this device.  Or, hmm...

Perhaps there needs to be some additional logic in check_wwan_device() as well? 
Right now it only detects MHI devices.

> @@ -1196,6 +1202,56 @@ static gboolean setup_mbim(struct modem_info *modem)
>   		else if (g_strcmp0(subsystem, "tty") == 0) {
>   			if (g_strcmp0(info->number, "02") == 0)
>   				atcmd = info->devnode;
> +		} else if (g_strcmp0(subsystem, "pci") == 0) {
> +			sprintf(path, "%s/wwan", udev_device_get_syspath(info->udev_device));
> +
> +			d = opendir(path);
> +			if (!d)
> +				return FALSE;

Hmm, so you are detecting some node (I assume root) of the device, then open 
coding custom detection logic based on the wwan subsystem provided sysfs links. 
What if the WWAN subsystem isn't enabled in the kernel?  Can udevng be made to 
work without these links?

At a high level, if WWAN subsystem is enabled, then udevng is redundant.  There 
needs to be a dedicated wwan subsystem detection plugin, however this is a 
missing piece in oFono at the moment.  Marcel, didn't you have some beginnings 
of this?

> +
> +			new_udev = udev_new();
> +
> +			while ((dir = readdir(d))) {
> +				if (g_strcmp0(dir->d_name, ".") == 0 ||
> +					g_strcmp0(dir->d_name, "..") == 0)
> +					continue;
> +
> +				sprintf(wwan_path, "%s/%s", path, dir->d_name);
> +
> +				wwan_device = udev_device_new_from_syspath(new_udev,
> +									wwan_path);
> +				net = udev_device_get_sysname(wwan_device);
> +
> +				// Parse all the subdirectories now

nit: We use C comments, not C++

> +				sd = opendir(wwan_path);
> +				while ((subdir = readdir(sd))) {
> +					if (subdir->d_type != DT_DIR)
> +						continue;
> +
> +					if (g_strcmp0(subdir->d_name, ".") == 0 ||
> +						g_strcmp0(subdir->d_name, "..") == 0)
> +						continue;
> +
> +					sprintf(sub_path, "%s/%s", wwan_path, subdir->d_name);
> +
> +					sub_device = udev_device_new_from_syspath(new_udev,
> +										sub_path);
> +					sub_subsystem = udev_device_get_subsystem(sub_device);
> +
> +					if (g_strcmp0(sub_subsystem, "wwan") == 0) {
> +						type = udev_device_get_sysattr_value(sub_device, "type");
> +
> +						if (g_strcmp0(type, "MBIM") == 0)
> +							ctl = udev_device_get_devnode(sub_device);
> +						else if (g_strcmp0(type, "AT") == 0)
> +							atcmd = udev_device_get_devnode(sub_device);
> +					}
> +				}
> +				closedir(sd);
> +				break;
> +			}
> +			closedir(d);
> +			udev_unref(new_udev);
>   		}
>   	}
>   

Regards,
-Denis
