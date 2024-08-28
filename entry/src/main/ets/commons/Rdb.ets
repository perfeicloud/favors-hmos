/*
 * https://gitee.com/harmonyos/codelabs/blob/master/Rdb/entry/src/main/ets/common/database/Rdb.ets#
 */
import { relationalStore } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';

const STORE_CONFIG: relationalStore.StoreConfig = {
  name: 'database.db',
  securityLevel: relationalStore.SecurityLevel.S1
}

export default class Rdb {
  private rdbStore: relationalStore.RdbStore | null = null;
  private tableName: string;
  private sqlCreateTable: string;
  private columns: Array<string>;

  constructor(tableName: string, sqlCreateTable: string, columns: Array<string>) {
    this.tableName = tableName;
    this.sqlCreateTable = sqlCreateTable;
    this.columns = columns;
  }

  getRdbStore(callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'getRdbStore() has no callback!');
      return;
    }
    if (this.rdbStore !== null) {
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'The rdbStore exists.');
      callback();
      return
    }
    let context: Context = getContext(this) as Context;
    relationalStore.getRdbStore(context, STORE_CONFIG, (err, rdb) => {
      if (err) {
        hilog.error(0x0000, 'RdbTag', '%{public}s', `gerRdbStore() failed, err: ${err}`);
        return;
      }
      this.rdbStore = rdb;
      this.rdbStore.executeSql(this.sqlCreateTable);
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'getRdbStore() finished.');
      callback();
    });
  }

  insertData(data: relationalStore.ValuesBucket, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'insertData() has no callback!');
      return;
    }
    let resFlag: boolean = false;
    const valueBucket: relationalStore.ValuesBucket = data;
    if (this.rdbStore) {
      this.rdbStore.insert(this.tableName, valueBucket, (err, ret) => {
        if (err) {
          hilog.error(0x0000, 'RdbTag', '%{public}s', `insertData() failed, err: ${err}`);
          callback(resFlag);
          return;
        }
        hilog.info(0x0000, 'RdbTag', '%{public}s', `insertData() finished: ${ret}`);
        callback(ret);
      });
    }
  }

  deleteData(predicates: relationalStore.RdbPredicates, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'deleteData() has no callback!');
      return;
    }
    let resFlag: boolean = false;
    if (this.rdbStore) {
      this.rdbStore.delete(predicates, (err, ret) => {
        if (err) {
          hilog.error(0x0000, 'RdbTag', '%{public}s', `deleteData() failed, err: ${err}`);
          callback(resFlag);
          return;
        }
        hilog.info(0x0000, 'RdbTag', '%{public}s', `deleteData() finished: ${ret}`);
        callback(!resFlag);
      });
    }
  }

  updateData(predicates: relationalStore.RdbPredicates, data: relationalStore.ValuesBucket, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'updateDate() has no callback!');
      return;
    }
    let resFlag: boolean = false;
    const valueBucket: relationalStore.ValuesBucket = data;
    if (this.rdbStore) {
      this.rdbStore.update(valueBucket, predicates, (err, ret) => {
        if (err) {
          hilog.error(0x0000, 'RdbTag', '%{public}s', `updateData() failed, err: ${err}`);
          callback(resFlag);
          return;
        }
        hilog.info(0x0000, 'RdbTag', '%{public}s', `updateData() finished: ${ret}`);
        callback(!resFlag);
      });
    }
  }

  query(predicates: relationalStore.RdbPredicates, callback: Function = () => {}) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      hilog.info(0x0000, 'RdbTag', '%{public}s', 'query() has no callback!');
      return;
    }
    if (this.rdbStore) {
      this.rdbStore.query(predicates, this.columns, (err, resultSet) => {
        if (err) {
          hilog.error(0x0000, 'RdbTag', '%{public}s', `query() failed, err:  ${err}`);
          return;
        }
        hilog.info(0x0000, 'RdbTag', '%{public}s', 'query() finished.');
        callback(resultSet);
        resultSet.close();
      });
    }
  }
}