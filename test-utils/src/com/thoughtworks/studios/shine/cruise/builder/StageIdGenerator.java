/*************************GO-LICENSE-START*********************************
 * Copyright 2014 ThoughtWorks, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *************************GO-LICENSE-END***********************************/

package com.thoughtworks.studios.shine.cruise.builder;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;


public class StageIdGenerator {


  private static Map<List<String>, Long> stageIds = new HashMap<List<String>, Long>();
  private static long lastId = 10000;

  public static long idFor(String pipelineName, int pipelineCounter, String stageName, int stageCounter) {
    List<String> key = new ArrayList<String>();
    key.add(pipelineName);
    key.add(String.valueOf(pipelineCounter));
    key.add(stageName);
    key.add(String.valueOf(stageCounter));
    if (!stageIds.containsKey(key)) {
      stageIds.put(key, ++lastId);
    }

    return stageIds.get(key);
  }

}
